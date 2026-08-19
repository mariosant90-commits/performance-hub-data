$ErrorActionPreference='Stop'
$root='C:\MT5Reporting'
$txt=Join-Path $root 'lpprime_v6_runtime.b64'
$zip=Join-Path $root 'LPPrime_v6.zip'
$tmp=Join-Path $root '_v6_install'
$url='https://raw.githubusercontent.com/mariosant90-commits/performance-hub-data/main/installers/lpprime_v6_runtime_20260819.b64'
New-Item -ItemType Directory -Path $root -Force | Out-Null
Write-Host 'Downloading V6 package...' -ForegroundColor Cyan
& curl.exe -L --fail --silent --show-error $url -o $txt
if($LASTEXITCODE -ne 0){throw 'Download failed'}
$b=[IO.File]::ReadAllText($txt).Trim()
[IO.File]::WriteAllBytes($zip,[Convert]::FromBase64String($b))
$hash=(Get-FileHash $zip -Algorithm SHA256).Hash
if($hash -ne '5A106667B94C0C309E469E1BA9074559F5B19487B85F50EBFEB7800D66483A6C'){throw "ZIP hash mismatch: $hash"}
Write-Host 'Package verified.' -ForegroundColor Green
Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
Expand-Archive $zip $tmp -Force
$installer=Join-Path $tmp 'install_all.ps1'
if(-not(Test-Path $installer)){throw 'install_all.ps1 missing after extraction'}
Write-Host 'Running installer...' -ForegroundColor Cyan
powershell.exe -NoProfile -ExecutionPolicy Bypass -File $installer
