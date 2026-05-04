$LogDir = "C:\Windows\Temp\Packer"
New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
Start-Transcript -Path "$LogDir\bootstrap.log" -Force

Write-Host "Starting bootstrap..."

powershell.exe -ExecutionPolicy Bypass -File F:\scripts\enable-winrm.ps1
# powershell.exe -ExecutionPolicy Bypass -File F:\scripts\install-vmware-tools.ps1

Write-Host "Bootstrap complete. Rebooting..."
Stop-Transcript

Restart-Computer -Force