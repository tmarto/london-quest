Add-Type -AssemblyName System.Drawing

$size = 512
$out = "C:\Users\tmart\Desktop\Claude\london_quest\assets\icon"
[System.IO.Directory]::CreateDirectory($out) | Out-Null

# ── OPTION 1: Flag Shield ─────────────────────────────────────────────────────
{
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g   = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode   = 'AntiAlias'
    $g.TextRenderingHint = 'AntiAliasGridFit'

    # Background
    $g.Clear([System.Drawing.Color]::FromArgb(255, 20, 22, 40))

    # Shield path (pentagon-ish)
    $cx = $size / 2
    $pts = @(
        [System.Drawing.PointF]::new($cx - 140, 80),
        [System.Drawing.PointF]::new($cx + 140, 80),
        [System.Drawing.PointF]::new($cx + 140, 310),
        [System.Drawing.PointF]::new($cx,        440),
        [System.Drawing.PointF]::new($cx - 140, 310)
    )
    $shieldBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 200, 16, 46))
    $g.FillPolygon($shieldBrush, $pts)

    # Union Jack cross (white vertical + horizontal)
    $crossBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $g.FillRectangle($crossBrush, $cx - 18, 80, 36, 360)   # vertical (clip to shield approx)
    $g.FillRectangle($crossBrush, $cx - 140, 215, 280, 36) # horizontal

    # Diagonal stripes (simplified St Andrew cross)
    $diagPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(180, 255, 255, 255), 18)
    $g.DrawLine($diagPen, $cx - 140, 80,  $cx + 140, 360)
    $g.DrawLine($diagPen, $cx + 140, 80,  $cx - 140, 360)

    # Re-draw thick cross on top
    $g.FillRectangle($crossBrush, $cx - 16, 80, 32, 360)
    $g.FillRectangle($crossBrush, $cx - 140, 218, 280, 30)

    # "LQ" monogram
    $font = New-Object System.Drawing.Font("Arial", 96, [System.Drawing.FontStyle]::Bold)
    $sf   = New-Object System.Drawing.StringFormat
    $sf.Alignment = 'Center'
    $g.DrawString("LQ", $font, ([System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)), $cx, 440, $sf)

    $bmp.Save("$out\option1_shield.png", [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
    Write-Host "Option 1 saved"
}.Invoke()

# ── OPTION 2: Big Ben Poster ──────────────────────────────────────────────────
{
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g   = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = 'AntiAlias'
    $g.TextRenderingHint = 'AntiAliasGridFit'

    # Radial-ish gradient bg: simulate with linear dark→red
    $bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        [System.Drawing.Point]::new(0,0),
        [System.Drawing.Point]::new(0,$size),
        [System.Drawing.Color]::FromArgb(255,180,10,30),
        [System.Drawing.Color]::FromArgb(255,60,0,10)
    )
    $g.FillRectangle($bgBrush, 0, 0, $size, $size)

    $w = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $cx = $size / 2

    # Base platform
    $g.FillRectangle($w, $cx-110, 400, 220, 22)

    # Tower body
    $g.FillRectangle($w, $cx-52,  240, 104, 162)

    # Belfry section (slightly wider)
    $g.FillRectangle($w, $cx-60, 185, 120, 60)

    # Clock face cutout
    $dark = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255,60,0,10))
    $g.FillEllipse($dark, $cx-36, 197, 72, 72)

    # Clock hands
    $handPen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 5)
    $g.DrawLine($handPen, $cx, 233, $cx,        210)   # 12
    $g.DrawLine($handPen, $cx, 233, $cx+22,     242)   # 3

    # Spire
    $spts = @(
        [System.Drawing.PointF]::new($cx,     105),
        [System.Drawing.PointF]::new($cx-18,  185),
        [System.Drawing.PointF]::new($cx+18,  185)
    )
    $g.FillPolygon($w, $spts)

    # Windows on tower
    $dark2 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(120,0,0,0))
    $g.FillRectangle($dark2, $cx-18, 260, 14, 22)
    $g.FillRectangle($dark2, $cx+4,  260, 14, 22)
    $g.FillRectangle($dark2, $cx-18, 300, 14, 22)
    $g.FillRectangle($dark2, $cx+4,  300, 14, 22)

    # "LONDON QUEST" text
    $fontL = New-Object System.Drawing.Font("Arial", 48, [System.Drawing.FontStyle]::Bold)
    $fontQ = New-Object System.Drawing.Font("Arial", 30, [System.Drawing.FontStyle]::Bold)
    $sf    = New-Object System.Drawing.StringFormat
    $sf.Alignment = 'Center'
    $g.DrawString("LONDON", $fontL, $w, $cx, 430, $sf)
    $red2 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255,255,180,180))
    $g.DrawString("QUEST", $fontQ, $red2, $cx, 468, $sf)

    $bmp.Save("$out\option2_bigben.png", [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
    Write-Host "Option 2 saved"
}.Invoke()

# ── OPTION 3: Underground Roundel ────────────────────────────────────────────
{
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g   = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = 'AntiAlias'
    $g.TextRenderingHint = 'AntiAliasGridFit'

    # Dark navy background
    $g.Clear([System.Drawing.Color]::FromArgb(255, 20, 22, 40))

    $cx = $size / 2; $cy = $size / 2
    $red   = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255,220,20,60))
    $white = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $navy  = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255,20,22,40))

    # Red outer ring (filled circle)
    $r = 200
    $g.FillEllipse($red, $cx-$r, $cy-$r, $r*2, $r*2)

    # Navy inner circle (to make ring)
    $ri = 150
    $g.FillEllipse($navy, $cx-$ri, $cy-$ri, $ri*2, $ri*2)

    # White bar across middle (roundel bar)
    $barH = 80
    $g.FillRectangle($white, $cx-$r, $cy-($barH/2), $r*2, $barH)

    # Clip the white bar to stay inside outer ring
    # (approximate: re-draw navy outside the ring edges)
    # Left cap
    $capBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255,20,22,40))
    $g.FillRectangle($capBrush, 0, 0, $cx-$r, $size)
    $g.FillRectangle($capBrush, $cx+$r, 0, $cx-$r, $size)

    # "LONDON" on white bar
    $fontL = New-Object System.Drawing.Font("Arial", 58, [System.Drawing.FontStyle]::Bold)
    $sfC   = New-Object System.Drawing.StringFormat
    $sfC.Alignment = 'Center'; $sfC.LineAlignment = 'Center'
    $barRect = [System.Drawing.RectangleF]::new($cx-$r, $cy-($barH/2), $r*2, $barH)
    $g.DrawString("LONDON", $fontL, $navy, $barRect, $sfC)

    # "QUEST" in white inside the inner circle (above bar)
    $fontQ = New-Object System.Drawing.Font("Arial", 44, [System.Drawing.FontStyle]::Bold)
    $sfC2  = New-Object System.Drawing.StringFormat
    $sfC2.Alignment = 'Center'
    $g.DrawString("QUEST", $fontQ, $white, $cx, $cy - 115, $sfC2)

    # Flag emoji substitute: small Union Jack colours arc (just dots)
    $g.DrawString("🇬🇧", (New-Object System.Drawing.Font("Segoe UI Emoji", 36)), $white, $cx - 26, $cy + 54, $sfC2)

    $bmp.Save("$out\option3_roundel.png", [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
    Write-Host "Option 3 saved"
}.Invoke()

Write-Host "All 3 options saved to $out"
