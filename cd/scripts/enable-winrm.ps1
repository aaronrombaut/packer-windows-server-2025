# Set network to Private
Get-NetConnectionProfile | ForEach-Object {
  Set-NetConnectionProfile -InterfaceIndex $_.InterfaceIndex -NetworkCategory Private
}

# Enable WinRM fully
winrm quickconfig -quiet

# Allow local admin remote access
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
  -Name "LocalAccountTokenFilterPolicy" -Value 1 -PropertyType DWord -Force

# Ensure service
Set-Service -Name WinRM -StartupType Automatic
Start-Service -Name WinRM

# Open firewall
Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"