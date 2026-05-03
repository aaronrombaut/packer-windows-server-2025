$flag = "C:\Windows\Temp\bootstrap.step"

if (!(Test-Path $flag)) {
  "step1" | Out-File $flag -Force
}

$step = Get-Content $flag

if ($step -eq "step1") {
  powershell -ExecutionPolicy Bypass -File E:\scripts\install-vmware-tools.ps1
  "step2" | Out-File $flag -Force
  Restart-Computer -Force
  exit
}

if ($step -eq "step2") {
  powershell -ExecutionPolicy Bypass -File E:\scripts\enable-winrm.ps1
  "done" | Out-File $flag -Force
  Restart-Computer -Force
  exit
}