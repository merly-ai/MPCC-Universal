#!/bin/bash

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

echo "Merly Install Script, Copyright (c) 2022 Merly, Inc."

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

base_url='https://merlyserviceadmin.azurewebsites.net/api/InstallUrl?name=MerlyInstaller&stable=true&os='
kernel=$(uname -s)
if [[ "$kernel" == "Linux" ]]; then
  os=$(grep ^NAME= /etc/os-release | awk -F= '{print $2}')
  url_request_url="${base_url}SUSE"
elif [[ "$kernel" == "Darwin" ]]; then
  if [[ "$(arch)" == "x86_64" ]] || [[ "$(arch)" == "i386" ]]; then
    url_request_url="${base_url}MacOS-x64"
  elif [[ "$(arch)" == "arm64" ]]; then
    url_request_url="${base_url}MacOS-arm64"
  else
    abort "Merly install script for Mac does not support $(arch) yet.  Please contact sales@merly.ai."
  fi
else
  abort "Merly install script is not yet supported for $kernel.  Please contact sales@merly.ai."
fi

if [[ -z "$url_request_url" ]]; then
  abort "Merly install script failed to setup URL to request MerlyInstaller.  Please contact sales@merly.ai."
fi
echo "Fetching Merly installer location..."
installer_url="$(curl -Ss -X GET "$url_request_url" -H "accept: */*")"
if [[ -z "$installer_url" ]]; then
  abort "Merly install script failed determine MerlyInstaller location.  Request URL: $url_request_url."
fi
echo "Downloading MerlyInstaller..."
if [[ -f MerlyInstaller ]]; then /bin/rm -f MerlyInstaller; fi
curl -LS -# -o MerlyInstaller $installer_url
if [[ ! -f MerlyInstaller ]]; then
  abort "Merly install script was unable to download MerlyInstaller from $installer_url"
fi
file_info="$(file MerlyInstaller)"
if [[ "$file_info" != *"executable"* ]]; then
  abort "Merly install script was unable find the proper MerlyInstaller from $installer_url"
fi
chmod +x MerlyInstaller
if [[ ! -x MerlyInstaller ]]; then
  abort "Merly install script was unable to mark MerlyInstaller executable"
fi

./MerlyInstaller install %1
