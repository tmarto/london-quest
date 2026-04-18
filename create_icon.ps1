Add-Type -AssemblyName System.Drawing

$size = 1024
$bmp = New-Object System.Drawing.Bitmap($size, $size)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# Background gradient (dark navy)
$brush1 = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    [System.Drawing.Point]::new(0, 0),
    [System.Drawing.Point]::new(0, $size),
    [System.Drawing.Color]::FromArgb(255, 26, 26, 46),
    [System.Drawing.Color]::FromArgb(255, 22, 33, 62)
)
$g.FillRectangle($brush1, 0, 0, $size, $size)

# Outer red circle
$redColor = [System.Drawing.Color]::FromArgb(255, 220, 20, 60)
$circleBrush = New-Object System.Drawing.SolidBrush($redColor)
$circleSize = 720
$circleX = ($size - $circleSize) / 2
$circleY = ($size - $circleSize) / 2 - 60
$g.FillEllipse($circleBrush, $circleX, $circleY, $circleSize, $circleSize)

# Inner dark circle
$innerBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 26, 26, 46))
$innerSize = 620
$innerX = ($size - $innerSize) / 2
$innerY = ($size - $innerSize) / 2 - 60
$g.FillEllipse($innerBrush, $innerX, $innerY, $innerSize, $innerSize)

# Big Ben silhouette (simplified rectangles)
$whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$cx = $size / 2

# Clock tower body
$g.FillRectangle($whiteBrush, $cx - 55, 220, 110, 300)
# Tower top section
$g.FillRectangle($whiteBrush, $cx - 45, 170, 90, 60)
# Clock face circle (dark)
$clockBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 26, 26, 46))
$g.FillEllipse($clockBrush, $cx - 35, 225, 70, 70)
# Clock hands
$handPen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 5)
$g.DrawLine($handPen, $cx, 260, $cx, 242)       # 12 o'clock hand
$g.DrawLine($handPen, $cx, 260, $cx + 22, 268)  # 3 o'clock hand
# Spire
$spirePoints = @(
    [System.Drawing.Point]::new($cx, 110),
    [System.Drawing.Point]::new($cx - 18, 170),
    [System.Drawing.Point]::new($cx + 18, 170)
)
$g.FillPolygon($whiteBrush, $spirePoints)
# Base
$g.FillRectangle($whiteBrush, $cx - 70, 520, 140, 30)

# "LONDON QUEST" text
$fontFamily = New-Object System.Drawing.FontFamily("Arial")
$titleFont = New-Object System.Drawing.Font($fontFamily, 72, [System.Drawing.FontStyle]::Bold)
$subFont   = New-Object System.Drawing.Font($fontFamily, 42, [System.Drawing.FontStyle]::Bold)

$textBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$redTextBrush = New-Object System.Drawing.SolidBrush($redColor)

$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = [System.Drawing.StringAlignment]::Center

$g.DrawString("LONDON", $titleFont, $textBrush, ($size / 2), 610, $sf)
$g.DrawString("QUEST", $subFont, $redTextBrush, ($size / 2), 710, $sf)

$g.Dispose()

$outPath = Join-Path $PSScriptRoot "assets\icon\app_icon.png"
$null = [System.IO.Directory]::CreateDirectory((Split-Path $outPath))
$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

Write-Host "Icon saved to $outPath"
