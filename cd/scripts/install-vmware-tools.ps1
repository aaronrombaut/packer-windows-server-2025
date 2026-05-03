$tools = Get-Volume | Where-Object {
  $_.DriveType -eq 'CD-ROM' -and (Test-Path "$($_.DriveLetter):\setup.exe")
} | Select-Object -First 1

if (-not $tools) { throw "VMware Tools ISO not found" }

Start-Process "$($tools.DriveLetter):\setup.exe" -ArgumentList '/S /v"/qn REBOOT=R"' -Wait