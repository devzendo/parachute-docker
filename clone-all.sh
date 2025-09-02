#!/bin/bash
#
# Clones all the Parachute repositories at the same level as this 'parachute-docker' clone
# if they do not already exist. Similarly the Raspberry Pi Pico SDKs.
#
set -euf -o pipefail

# Move to the folder the script is in (for consistency) - https://stackoverflow.com/a/246128
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1

function clone_parachute() {
  clone_url "$1" "https://github.com/devzendo/$1.git"
}

function clone_url() {
  OLDPWD=`pwd`
  cd ..
  if [ ! -d "$1" ]; then
    git clone "$2.git" "$1"
  fi
  cd "$OLDPWD"
}
  
clone_parachute transputer-emulator
clone_parachute transputer-eforth
clone_parachute transputer-macro-assembler
clone_parachute retro-c-compiler

clone_url PICO_SDK https://github.com/raspberrypi/pico-sdk
clone_url PICO_EXTRAS https://github.com/raspberrypi/pico-extras

