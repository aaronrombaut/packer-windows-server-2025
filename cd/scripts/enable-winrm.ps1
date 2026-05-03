# Set all networks to Private
Get-NetConnectionProfile | ForEach-Object {
  Set-NetConnectionProfile -InterfaceIndex $_.InterfaceIndex -NetworkCategory Private
}

# Enable WinRM
Enable-PSRemoting -Force

# Ensure service
Set-Service -Name WinRM -StartupType Automatic
Start-Service -Name WinRM

# Open firewall
Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"