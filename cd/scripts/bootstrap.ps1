Start-Transcript -Path C:\Windows\Temp\bootstrap.log -Force

# Wait for network
Start-Sleep -Seconds 20

# Set to Private
Get-NetConnectionProfile | ForEach-Object {
  Set-NetConnectionProfile -InterfaceIndex $_.InterfaceIndex -NetworkCategory Private -ErrorAction SilentlyContinue
}

# Enable WinRM
winrm quickconfig -quiet
Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"

# Install VMware Tools
$tools = Get-Volume | Where-Object {
  $_.DriveType -eq 'CD-ROM' -and (Test-Path "$($_.DriveLetter):\setup64.exe")
} | Select-Object -First 1

if ($tools) {
  Start-Process "$($tools.DriveLetter):\setup.exe" -ArgumentList '/S /v"/qn REBOOT=R"' -Wait
}

Restart-Computer -Force