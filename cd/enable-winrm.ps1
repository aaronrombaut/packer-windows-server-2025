# Set network to Private
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private

# Enable WinRM
Enable-PSRemoting -Force

# Ensure WinRM service is running
Set-Service -Name WinRM -StartupType Automatic
Start-Service -Name WinRM

# Open firewall for WinRM
Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"