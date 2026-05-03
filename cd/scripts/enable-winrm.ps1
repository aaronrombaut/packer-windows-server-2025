Start-Sleep -Seconds 20

for ($i=0; $i -lt 5; $i++) {
  Get-NetConnectionProfile | ForEach-Object {
    Set-NetConnectionProfile -InterfaceIndex $_.InterfaceIndex -NetworkCategory Private -ErrorAction SilentlyContinue
  }
  Start-Sleep -Seconds 5
}

winrm quickconfig -quiet

New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
  -Name "LocalAccountTokenFilterPolicy" -Value 1 -PropertyType DWord -Force

Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"