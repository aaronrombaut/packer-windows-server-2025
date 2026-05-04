$tools = Get-Volume | Where-Object {
  $_.DriveType -eq 'CD-ROM' -and (Test-Path "$($_.DriveLetter):\setup.exe")
} | Select-Object -First 1

if (-not $tools) { throw "VMware Tools ISO not found" }

if ($tools) {
#  Start-Process -FilePath "$($tools.DriveLetter):\setup.exe" -ArgumentList "/s","/v/qn" -Wait
  cmd.exe /c "$($tools.DriveLetter):\setup.exe /s /v/qn"
}
