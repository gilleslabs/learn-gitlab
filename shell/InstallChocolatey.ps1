$env:chocolateyVersion = '0.9.9.12'
$ChocoInstallPath = "$env:SystemDrive\ProgramData\Chocolatey\bin"
					
  if (!(Test-Path $ChocoInstallPath)) {
      iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
  }
