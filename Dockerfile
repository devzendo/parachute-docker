#
# Parachute docker container definition.
#
FROM amd64/debian:trixie-slim
RUN set -ex; apt-get update
#
# Python 3 (for GoogleTest)
#
RUN set -ex; apt-get install -y python3 
#
# Eclipse Temurin 17 JDK (for Maven; for the transputer-assembler build)
#
RUN set -ex; apt-get install -y wget apt-transport-https
RUN set -ex; echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print $2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
RUN set -ex; mkdir -p /etc/apt/keyrings; wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
RUN set -ex; apt-get update; apt-get install -y temurin-17-jdk
#
# Apache Maven 3.9.9 (for the transputer-assembler build)
#
RUN set -ex; apt-get install -y maven
#
# GCC, CMake (for the transputer-emulator build)
#
RUN set -ex; apt-get install -y build-essential g++-11 make cmake
RUN set -ex; mkdir -p /opt/cmake/bin; ln -s /usr/bin/cmake /opt/cmake/bin/cmake; ln -s /usr/bin/ctest /opt/cmake/bin/ctest
#
# GCC for Raspberry Pi Pico builds (for the transputer-emulator build)
#
RUN set -ex; apt-get install -y gcc-arm-none-eabi libnewlib-arm-none-eabi
#
# Git for cloning other repos and Pico SDKs
#
RUN set -ex; apt-get install -y git
#
# Rust (for retro-c-compiler)
#
RUN set -ex; apt-get install -y rustup
RUN set -ex; rustup toolchain install 1.89.0; \
    rustup default 1.89.0
#
# sudo so the installation scripts can install in /opt/parachute
#
RUN set -ex; apt-get install -y sudo


