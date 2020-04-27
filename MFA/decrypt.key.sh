#!/bin/bash
# Purpose: Display 2FA code on screen
# --------------------------------------------------------------------------
# Path to gpg2 binary
_gpg="/usr/bin/gpg"
_oathtool="/usr/bin/oathtool"

## run: gpg --list-secret-keys --keyid-format LONG to get uid and kid ##
# GnuPG user id
uid="email address here"

# GnuPG key id
kid="full gpg ID here"

# Directory
dir="$HOME/2fa"

# Build CLI arg
s="$1"
k="${dir}/${s}/.key"
kg="${k}.gpg"

# failsafe stuff
[ "$1" == "" ] && { echo "Usage: $0 service"; exit 1; }
[ ! -f "$kg" ] && { echo "Error: Encrypted file \"$kg\" not found."; exit 2; }

# Get totp secret for given service
totp=$($_gpg --quiet -u "${kid}" -r "${uid}" --decrypt "$kg")

# Generate 2FA totp code and display on screen
echo "Your code for $s is ..."
code=$($_oathtool -b --totp "$totp")
## Copy to clipboard too ##
## if xclip command found  on Linux system ##
type -a xclip &>/dev/null
[ $? -eq 0 ] && { echo $code | xclip -sel clip; echo "*** Code copied to clipboard too ***"; }
echo "$code"

# Make sure we don't have .key file in plain text format ever #
[ -f "$k" ] && echo "Warning - Plain text key file \"$k\" found."
