# bootstrap.ps1

# Install VMware Tools (from attached ISO)
$cd = Get-Volume | Where-Object {
  $_.DriveType -eq 'CD-ROM' -and (Test-Path "$($_.DriveLetter):\setup64.exe")
} | Select-Object -First 1

if (-not $cd) { throw "VMware Tools ISO not found" }

Start-Process "$($cd.DriveLetter):\setup64.exe" -ArgumentList '/S /v"/qn REBOOT=R"' -Wait