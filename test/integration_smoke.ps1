$ErrorActionPreference = 'Stop'

$godotExe = "E:/Tools/Godot_v4.6.1-stable_win64.exe/Godot_v4.6.1-stable_win64.exe"
$projectPath = "E:/Development/PNGTuber-Plus"

if (!(Test-Path $godotExe)) {
    Write-Error "Godot executable not found: $godotExe"
    exit 1
}

$tmpLog = Join-Path $env:TEMP "pngtuber_integration_smoke.log"
if (Test-Path $tmpLog) {
    Remove-Item $tmpLog -Force
}

& $godotExe --headless --path $projectPath --quit-after 2 2>&1 | Tee-Object -FilePath $tmpLog | Out-Null

$logText = Get-Content $tmpLog -Raw
$errorMarkers = @(
    "SCRIPT ERROR:",
    "ERROR: Failed to load script"
)

foreach ($marker in $errorMarkers) {
    if ($logText -match [regex]::Escape($marker)) {
        Write-Host "Integration smoke failed: found '$marker' in startup output."
        Write-Host "Log file: $tmpLog"
        exit 1
    }
}

Write-Host "Integration smoke passed: no script compilation/runtime startup errors detected."
exit 0
