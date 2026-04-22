# daily_merge_release.ps1
# Checks open PRs, merges those with passing CI, then auto-releases if main CI passes.
# Run daily by Claude scheduler.

param(
    [string]$RepoRoot = 'C:\Users\tmart\Desktop\Claude\london_quest',
    [string]$GhToken  = '',   # injected at call time; never hardcode here
    [string]$Gh       = 'C:\Program Files\GitHub CLI\gh.exe'
)

Set-Location $RepoRoot
[System.Environment]::SetEnvironmentVariable('GH_TOKEN', $GhToken, 'Process')

function Log($msg) { Write-Host "[$(Get-Date -f 'HH:mm:ss')] $msg" }

# ── 1. Fetch open PRs ─────────────────────────────────────────────────────────
Log "Fetching open PRs..."
$prs = & $Gh pr list --state open --json number,title,headRefName |
       ConvertFrom-Json

if (-not $prs -or $prs.Count -eq 0) {
    Log "No open PRs. Nothing to do."
    exit 0
}
Log "Found $($prs.Count) open PR(s)."

# ── 2. Merge PRs whose CI is fully passing ─────────────────────────────────────
$merged = 0
foreach ($pr in $prs) {
    $n = $pr.number
    Log "Checking PR #$n: $($pr.title)"

    # Get check statuses
    $checks = & $Gh pr checks $n --json name,state,conclusion 2>&1 |
              ConvertFrom-Json

    $failing = $checks | Where-Object {
        $_.state -eq 'FAILURE' -or $_.conclusion -eq 'failure' -or
        $_.state -eq 'ERROR'   -or $_.conclusion -eq 'cancelled'
    }
    $pending = $checks | Where-Object {
        $_.state -in @('PENDING','IN_PROGRESS','QUEUED') -and
        $_.conclusion -notin @('success','skipped')
    }

    if ($failing) {
        Log "  PR #$n has $($failing.Count) failing check(s). Skipping."
        continue
    }
    if ($pending) {
        Log "  PR #$n still has $($pending.Count) pending check(s). Skipping."
        continue
    }

    Log "  PR #$n all checks passed. Merging (squash)..."
    $result = & $Gh pr merge $n --squash --delete-branch 2>&1
    if ($LASTEXITCODE -eq 0) {
        Log "  PR #$n merged."
        $merged++
    } else {
        Log "  PR #$n merge failed: $result"
    }
}

if ($merged -eq 0) {
    Log "No PRs were merged. Exiting."
    exit 0
}

# Pull latest main
Log "Pulling latest main..."
git pull origin main --ff-only | Out-Null

# ── 3. Wait for main CI to pass ───────────────────────────────────────────────
Log "Waiting up to 20 min for main CI..."
$deadline = (Get-Date).AddMinutes(20)
$runId    = $null

# Give CI time to queue
Start-Sleep 15

while ((Get-Date) -lt $deadline) {
    $runs = & $Gh run list --branch main --workflow ci.yml --limit 1 `
              --json databaseId,status,conclusion | ConvertFrom-Json
    if ($runs -and $runs[0]) {
        $r = $runs[0]
        if ($r.status -eq 'completed') {
            $runId = $r.databaseId
            if ($r.conclusion -eq 'success') {
                Log "Main CI passed (run $runId)."
                break
            } else {
                Log "Main CI failed ($($r.conclusion)). Aborting release."
                exit 1
            }
        }
        Log "  CI status: $($r.status)... waiting"
    }
    Start-Sleep 30
}

if (-not $runId) {
    Log "CI timed out. Aborting release."
    exit 1
}

# ── 4. Bump patch version ─────────────────────────────────────────────────────
Log "Bumping version..."
$pubspec = Get-Content "$RepoRoot\pubspec.yaml" -Raw
if ($pubspec -match 'version:\s+(\d+)\.(\d+)\.(\d+)\+(\d+)') {
    $maj   = [int]$Matches[1]
    $min   = [int]$Matches[2]
    $patch = [int]$Matches[3] + 1
    $build = [int]$Matches[4] + 1
    $newVer = "$maj.$min.$patch+$build"
    $pubspec = $pubspec -replace 'version:\s+[\d.]+\+\d+', "version: $newVer"
    Set-Content "$RepoRoot\pubspec.yaml" $pubspec -NoNewline
    Log "Version bumped to $newVer"
} else {
    Log "Could not parse version in pubspec.yaml. Aborting."
    exit 1
}

$tag = "v$maj.$min.$patch"

# ── 5. Commit, push, tag, release ────────────────────────────────────────────
Log "Committing version bump..."
git add pubspec.yaml
git commit -m "chore: bump version to $newVer for $tag release [skip-release-notes]"
git push origin main

Log "Tagging $tag and creating release..."
git tag $tag
git push origin $tag

& $Gh release create $tag --title $tag --generate-notes

Log "Done. Released $tag."
