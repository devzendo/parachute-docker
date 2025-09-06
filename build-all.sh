#!/bin/bash
#
# To be run in the container, builds all the cloned Parachute components at the
# same level as this 'parachute-docker' clone.
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

UPONE="${PWD%/*}"

if [ ! -f /.dockerenv ]; then
  echo This script must be run from inside the parachute-docker container
  exit 1
fi

cd ..

mkdir -p ${UPONE}/maven-local-repo
export MVN='mvn -Dmaven.repo.local=${UPONE}/maven-local-repo'

echo Transputer Macro Assembler...
(cd transputer-macro-assembler; ${MVN} clean package; ./install-linux.sh)

echo Transputer Emulator for Linux...
(cd transputer-emulator; ./full-desktop-build.sh; ./install-linux.sh)

echo Transputer Emulator for Raspberry Pi Pico...
export PICO_SDK_PATH=${UPONE}/PICO_SDK
export PICO_EXTRAS_PATH=${UPONE}/PICO_EXTRAS
(cd transputer-emulator; \
  rm -rf cmake-build-debug; \
  ${MVN} clean; \
  # The mvn compile will fail with 'dangerous relocation: unsupported relocation'
  # so then run the essentials again, and it'll work... ¯\_ (ツ)_/¯
  ${MVN} -DCROSS=PICO compile -P build || cmake --build cmake-build-debug --target all; \
  cp cmake-build-debug/Emulator/temulate.uf2 /opt/parachute/bin; \
)

echo Transputer eForth...
export PATH=$PATH:/opt/parachute/bin
(cd transputer-eforth/eForth; make; cp EFORTH.{BIN,LST,SYM} /opt/parachute/bin)

echo Retro C Compiler...
(cd retro-c-compiler; cargo test --release; cargo build --release; cp target/release/{rcc,rcc1} /opt/parachute/bin)


