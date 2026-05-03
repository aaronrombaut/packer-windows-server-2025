# Enable WinRM
Get-NetConnectionProfile | ForEach-Object {
  Set-NetConnectionProfile -InterfaceIndex $_.InterfaceIndex -NetworkCategory Private
}

winrm quickconfig -quiet

New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
  -Name "LocalAccountTokenFilterPolicy" -Value 1 -PropertyType DWord -Force

Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"

# Install VMware Tools
$tools = Get-Volume | Where-Object {
  $_.DriveType -eq 'CD-ROM' -and (Test-Path "$($_.DriveLetter):\setup64.exe")
} | Select-Object -First 1

if ($tools) {
  Start-Process "$($tools.DriveLetter):\setup64.exe" -ArgumentList '/S /v"/qn REBOOT=R"' -Wait
}