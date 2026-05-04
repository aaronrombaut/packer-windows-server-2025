$LogDir = "C:\Windows\Temp\Packer"
New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
Start-Transcript -Path "$LogDir\install-vmware-tools.log" -Force

$ErrorActionPreference = "Continue"

Write-Host "Searching for VMware Tools ISO..."

$tools = Get-Volume | Where-Object {
  $_.DriveType -eq 'CD-ROM' -and (Test-Path "$($_.DriveLetter):\setup.exe")
} | Select-Object -First 1

if (-not $tools) {
  Write-Host "VMware Tools ISO not found."
  Stop-Transcript
  exit 1
}

Write-Host "VMware Tools found on drive $($tools.DriveLetter):"

cmd.exe /c "$($tools.DriveLetter):\setup.exe /s /v/qn"

Write-Host "VMware Tools installer command completed."

Stop-Transcript