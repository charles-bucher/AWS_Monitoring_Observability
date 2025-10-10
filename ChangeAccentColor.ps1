param(
    [int]$AccentColor = 65280
)

$RegPath = "HKCU:\Software\Microsoft\Windows\DWM"

Set-ItemProperty -Path $RegPath -Name "AccentColor" -Value $AccentColor

Stop-Process -Name explorer -Force
Start-Process explorer

Write-Host "Accent color changed to $AccentColor."
