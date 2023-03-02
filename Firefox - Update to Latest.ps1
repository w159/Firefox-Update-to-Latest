function {

$ProgressPreference = 'SilentlyContinue'

$webResponse = (Invoke-WebRequest -Uri 'https://product-details.mozilla.org/1.0/firefox_versions.json').Content
$GetLatest = $webResponse | ConvertFrom-Json 
$FirefoxLatestVersion = $GetLatest | Select-Object -ExpandProperty "LATEST_FIREFOX_VERSION"

$FirefoxX86EXE = "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
$FireFoxx86Test = Test-Path $FirefoxX86EXE
$FirefoxInstalledVersionX86 = (Get-Item $FirefoxX86EXE).VersionInfo | Select-Object -ExpandProperty ProductVersion

$FirefoxX64EXE = "C:\Program Files\Mozilla Firefox\firefox.exe"
$FirefoxX64Test = Test-Path $FirefoxX64EXE
$FirefoxInstalledVersionX64 = (Get-Item $FirefoxX64EXE).VersionInfo | Select-Object -ExpandProperty ProductVersion


if ($FireFoxx86Test -eq $true) {
    if ($FirefoxInstalledVersionX86 -NE $FirefoxLatestVersion) {

        Write-Host "UPDATING FIREFOX"
        New-Item -Path "C:\" -Name "Utils" -ItemType Directory -Force
        Invoke-WebRequest -Uri 'https://download.mozilla.org/?product=firefox-latest-ssl&os=win&lang=en-US' -OutFile "C:\Utils\FirefoxX32LatestSetup.exe"
        Start-Process "C:\Utils\FirefoxX32LatestSetup.exe" -ArgumentList "/S /DesktopShortcut=false /TaskbarShortcut=false /StartMenuShortcut=false"

    }
}

if ($FirefoxX64Test -eq $true) {
    if ($FirefoxInstalledVersionX64 -NE $FirefoxLatestVersion) {

        Write-Host "UPDATING FIREFOX"
        New-Item -Path "C:\" -Name "Utils" -ItemType Directory -Force
        Invoke-WebRequest -Uri 'https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US' -OutFile "C:\Utils\FirefoxX64LatestSetup.exe"
        Start-Process "C:\Utils\FirefoxX64LatestSetup.exe" -ArgumentList "/S /DesktopShortcut=false /TaskbarShortcut=false /StartMenuShortcut=false"

    }
}


}

