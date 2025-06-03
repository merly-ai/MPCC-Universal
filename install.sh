#!/bin/bash

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

# Fail fast with a concise message when not using bash
# Single brackets are needed here for POSIX compatibility
# shellcheck disable=SC2292
if [ -z "${BASH_VERSION:-}" ]; then
  abort "Bash is required to interpret this script."
fi

# Check if script is run with force-interactive mode in CI
if [[ -n "${CI-}" && -n "${INTERACTIVE-}" ]]; then
  abort "Cannot run force-interactive mode in CI."
fi

# Check if both `INTERACTIVE` and `NONINTERACTIVE` are set
# Always use single-quoted strings with `exp` expressions
# shellcheck disable=SC2016
if [[ -n "${INTERACTIVE-}" && -n "${NONINTERACTIVE-}" ]]; then
  abort 'Both `$INTERACTIVE` and `$NONINTERACTIVE` are set. Please unset at least one variable and try again.'
fi

base_url='https://merlyserviceadmin.azurewebsites.net/api/InstallUrl?name=MerlyInstaller'

quiet=0
channel=Release
dry_run=0
download_only=0
installer_exe=MerlyInstaller
curl_args="-#"

if ! [[ -z ${MERLY_CHANNEL+x} ]]; then channel=${MERLY_CHANNEL}; fi
if ! [[ -z ${MERLY_QUIET+x} ]]; then quiet=${MERLY_QUIET}; fi
if ! [[ -z ${MERLY_DRYRUN+x} ]]; then dry_run=${MERLY_DRYRUN}; fi
if ! [[ -z ${MERLY_DOWNLOAD_ONLY+x} ]]; then download_only=${MERLY_DOWNLOAD_ONLY}; fi
for ((i=1; i<=$#; i++)); do
  var=${!i}
  if [[ "$var" == "--staging" ]]; then
    staging=1
  elif [[ "$var" == "-q" ]]; then
    quiet=1
  elif [[ "$var" == "--dry-run" ]]; then
    dry_run=1
  elif [[ "$var" == "--download-only" ]]; then
    download_only=1
  elif [[ "$var" == "--channel="* ]]; then
    channel=${var#*=}
  fi
done

if [[ "$channel" != "Release" ]]; then
  installer_exe=MerlyInstaller-$channel
fi
if (( $quiet == 1 )); then
  curl_args="-s"
fi

if (( $quiet == 0 )); then
  echo "Merly Install Script, Copyright (c) 2022-2025 Merly, Inc."
fi

base_url="${base_url}&channel=${channel}"

kernel=$(uname -s)
if [[ "$kernel" == "Linux" ]]; then
  url_request_url="${base_url}&os=Linux"
  arch=$(uname -m)
  if [[ "$arch" == "aarch64" ]]; then
    curl -s -X GET "https://merlyserviceadmin.azurewebsites.net/api/InstallLog?os=Linux&arch=$arch"
    abort "Merly does not support arm64 architecture on Linux. Please contact sales@merly.ai."
  fi
elif [[ "$kernel" == "Darwin" ]]; then
  url_request_url="${base_url}&os=MacOS"
  arch=$(uname -m)
  version=$(sw_vers -productVersion)
  major_version=$(echo $version | cut -d. -f1)
  if [[ "$arch" == "x86_64" ]]; then
    curl -s -X GET "https://merlyserviceadmin.azurewebsites.net/api/InstallLog?os=MacOS&arch=$arch"
    abort "Merly does not support x64 (Intel) architecture on MacOS. Please contact sales@merly.ai."
  elif [[ $major_version -le 12 ]]; then
    curl -s -X GET "https://merlyserviceadmin.azurewebsites.net/api/InstallLog?os=MacOS&arch=$arch&osversion=$version"
    abort "Merly does not support MacOS version 12 or older. Your version is $version. Please contact sales@merly.ai."
  fi
else
  curl -s -X GET "https://merlyserviceadmin.azurewebsites.net/api/InstallLog?os=$kernel"
  abort "Merly does not support your OS $kernel. Please contact sales@merly.ai."
fi

if (( $quiet == 0 )); then
  echo "Fetching Merly installer location..."
fi
installer_url="$(curl -Ss -X GET "$url_request_url" -H "accept: */*" --retry 5 --retry-all-errors)"
if [[ -z "$installer_url" ]]; then
  abort "Merly install script failed determine $installer_exe location.  Request URL: $url_request_url."
fi
if (( $quiet == 0 )); then
  echo "Downloading $installer_exe..."
fi

# Check if current directory is HOME, Desktop, or Downloads
current_dir=$(pwd)
home_dir="$HOME"
desktop_dir="$HOME/Desktop"
downloads_dir="$HOME/Downloads"

installer_path="$installer_exe"  # Default: download to current directory
use_merly_folder=0

if [[ "$current_dir" == "$home_dir" || "$current_dir" == "$desktop_dir" || "$current_dir" == "$downloads_dir" ]]; then
  merly_folder="Merly.ai"
  if (( $quiet == 0 )); then
    echo "Current directory is HOME, Desktop, or Downloads. Using $merly_folder subfolder."
  fi
  mkdir -p "$merly_folder" || abort "Failed to create $merly_folder directory."
  installer_path="$merly_folder/$installer_exe"
  use_merly_folder=1
fi

if (( $dry_run == 1 )); then
  echo "DRY-RUN: quiet=${quiet}, channel=${channel}, url=${url_request_url}, download=${installer_url}, installer=${installer_path}"
  exit 0
fi

if [[ -f "$installer_path" ]]; then /bin/rm -f "$installer_path"; fi

curl -LS $curl_args -o "$installer_path" $installer_url --retry 5 --retry-all-errors
if [[ ! -f "$installer_path" ]]; then
  abort "Merly install script was unable to download $installer_exe to $installer_path from $installer_url"
fi
file_info="$(file "$installer_path")"
if [[ "$file_info" != *"executable"* ]]; then
  abort "Merly install script was unable find the proper $installer_exe from $installer_url"
fi

chmod +x "$installer_path"
if [[ ! -x "$installer_path" ]]; then
  abort "Merly install script was unable to mark $installer_path executable"
fi

if (( $download_only == 0 )); then
  ./"$installer_path" $@
elif (( $quiet == 0 )); then
  echo "SUCCESS: $installer_path Downloaded."
fi