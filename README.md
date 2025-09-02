# parachute-docker

## What is this?
A Docker container definition, containing all the build tools needed to work on
any part of the Parachute project - emulator, tools, etc.

## Project Status
Started September 2025.
Last changes in September 2025.

# Overview
Parachute is comprised of several parts written in a variety of languages,
such as C++, Rust, Scala, Transputer Assembler.

The releases are made occasionally using a set of Jenkins hosts, running
Windows 10, macOS Catalina, a variety of Ubuntu versions, and a Raspberry Pi.

Most development is done on Linux Mint 22.1, which is based on Ubuntu 24.04,
which is based on Debian trixie/sid.

This container is based on Debian trixie/sid.

This container makes working on Parachute easier, by providing a working set
of all necessary development tools. I use this container on the above Mint
system.

# Building
You will need docker: install the docker.io and docker-buildx packages.
Add yourself to the docker group:
  sudo usermod -aG docker $USER
  newgrp docker

To have cloned this project, you'll need git.

Once you have cloned this project, run `clone-all.sh`, which will clone all
the other parts of Parachute into directories at the same level as this project.

To build the image, run `build.sh`. This builds an image tagged `parachute-latest`.

To use the container, run `parachute-container.sh`.

# License, Copyright & Contact info
This code is released under the Apache 2.0 License: http://www.apache.org/licenses/LICENSE-2.0.html.

(C) 2025 Matt J. Gumbley.

matt.gumbley@devzendo.org

Mastodon: @M0CUV@mastodon.radio

http://devzendo.github.io/parachute


