#!/bin/bash
# Purpose: Encrypt the totp secret stored in $dir/$service/.key file
# Path to gpg binary
_gpg="/usr/bin/gpg"

## run: gpg --list-secret-keys --keyid-format LONG to get uid and kid ##
# GnuPG user id
uid="email address here"

# GnuPG key id
kid="Full GPG ID here"

# Directory that stores encrypted key for each service
dir="$HOME/2fa"

# Now build CLI args
s="$1"
k="${dir}/${s}/.key"
kg="${k}.gpg"

# failsafe stuff
[ "$1" == "" ] && { echo "Usage: $0 service"; exit 1; }
[ ! -f "$k" ] && { echo "$0 - Error: $k file not found."; exit 2; }
[ -f "$kg" ] && { echo "$0 - Error: Encrypted file \"$kg\" exists."; exit 3; }

# Encrypt your service .key file
$_gpg -u "${kid}" -r "${uid}" --encrypt "$k" && rm -i "$k"
