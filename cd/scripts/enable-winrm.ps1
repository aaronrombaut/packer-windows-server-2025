# Force all network profiles to Private
Get-NetConnectionProfile | ForEach-Object {
    Set-NetConnectionProfile -InterfaceIndex $_.InterfaceIndex -NetworkCategory Private -ErrorAction SilentlyContinue
}

# Enable WinRM listener + firewall rules
Enable-PSRemoting -Force

# Ensure WinRM service
Set-Service WinRM -StartupType Automatic
Start-Service WinRM

# Allow local Administrator over remote UAC
New-ItemProperty `
  -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
  -Name "LocalAccountTokenFilterPolicy" `
  -Value 1 `
  -PropertyType DWord `
  -Force

# Allow Basic/unencrypted for Packer HTTP WinRM build use
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'

# Explicit firewall rules
Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"
Enable-NetFirewallRule -DisplayGroup "File and Printer Sharing"

# Verify
winrm enumerate winrm/config/listener
netstat -an | findstr 5985