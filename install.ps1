param (
  [switch]$quiet = $false,
  [switch]$staging = $false,
  [switch]$dry_run = $false,
  [switch]$download_only = $false
)

$installer_exe="MerlyInstaller.exe"
$base_url="https://merlyserviceadmin.azurewebsites.net/api/InstallUrl?name=MerlyInstaller&os=Windows"
$installer_args = @("install")

if ($staging) {
  $url_request_url = "$base_url&stable=false"
  $installer_exe="MerlyInstaller-Staging.exe"
  $installer_args += "--staging"
} else {
  $url_request_url = "$base_url&stable=true"
}

if ($quiet) {
  $installer_args += "-q"
}

if ( ! $quiet ) {
  echo "Merly Install Script, Copyright (c) 2022 Merly, Inc."
  echo "Fetching Merly installer location..."
}

$installer_url = curl "$url_request_url"

if ( ! $quiet ) {
  echo "Downloading $installer_exe..."
}

if ( $dry_run ) {
  echo "DRY-RUN: quiet=$quiet, staging=$staging, url=$url_request_url, download=$installer_url, installer=$installer_exe"
  exit 0
}

if ( Test-Path $installer_exe ) { rm $installer_exe }
curl "$installer_url" -OutFile $installer_exe

if ( $download_only ) {
 echo "SUCCESS: $installer_exe Downloaded."
 exit
}
Start-Process -FilePath $installer_exe -NoNewWindow -Wait -ArgumentList $installer_args