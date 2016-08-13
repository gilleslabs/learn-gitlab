
$1 = New-WinUserLanguageList en-US
$1.Add("fr-FR")
Set-WinUserLanguageList $1 -Force

$HomeUrl="http://10.154.128.50"
set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\main' -Name "Start Page" -Value $HomeUrl


$file = "$env:windir\System32\drivers\etc\hosts"
"10.154.128.51 win-client.example.com" | Add-Content -PassThru $file
choco install -y googlechrome
$env:Path = $env:Path + ";C:\Program Files\Git\usr\bin"

#netsh advfirewall set allprofiles state off

Rename-Computer WINCLIENT
Restart-Computer -Force

