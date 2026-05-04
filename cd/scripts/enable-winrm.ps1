$LogDir = "C:\Windows\Temp\Packer"
New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
Start-Transcript -Path "$LogDir\enable-winrm.log" -Force

$ErrorActionPreference = "Continue"

Write-Host "Starting WinRM configuration..."

Get-NetConnectionProfile | ForEach-Object {
    Write-Host "Setting network profile to Private: $($_.Name)"
    Set-NetConnectionProfile -InterfaceIndex $_.InterfaceIndex -NetworkCategory Private -ErrorAction SilentlyContinue
}

Enable-PSRemoting -Force

Set-Service WinRM -StartupType Automatic
Start-Service WinRM

New-ItemProperty `
  -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
  -Name "LocalAccountTokenFilterPolicy" `
  -Value 1 `
  -PropertyType DWord `
  -Force

winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'

Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"
Enable-NetFirewallRule -DisplayGroup "File and Printer Sharing"

Write-Host "WinRM listener:"
winrm enumerate winrm/config/listener

Write-Host "Port 5985:"
netstat -an | findstr 5985

Stop-Transcript