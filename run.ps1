# Run.ps1 — drives your working wallpaper.exe

$base = $env:AUTOBLOOM_PATH
if (-not $base) { Write-Host "AUTOBLOOM_PATH not set." ; exit 1 }

$modeFile = Join-Path $base "bloom-mode.txt"
if (-not (Test-Path $modeFile)) { Write-Host "bloom-mode.txt missing." ; exit 1 }

$mode = (Get-Content $modeFile -Raw).Trim().ToLower()
$src  = Join-Path $base "src"

switch ($mode) {
  'dark' {
    $video = Join-Path $src 'bloom-dark.mp4'
    $image = Join-Path $src 'bloom-dark.png'
  }
  default {
    $video = Join-Path $src 'bloom-light.mp4'
    $image = Join-Path $src 'bloom-light.png'
  }
}

$exe = Join-Path $base 'wallpaper.exe'
if (-not (Test-Path $exe))   { Write-Host "wallpaper.exe not found." ; exit 1 }
if (-not (Test-Path $video)) { Write-Host "Video not found: $video"  ; exit 1 }
if (-not (Test-Path $image)) { Write-Host "Image not found: $image"  ; exit 1 }

# Launch silently; your EXE will:
#  - render MPV behind icons/taskbar
#  - wait for MPV to finish
#  - set the final static wallpaper
Start-Process -FilePath $exe -ArgumentList "`"$video`" `"$image`"" -Wait
