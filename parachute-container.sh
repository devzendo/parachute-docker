#!/bin/bash
#
# Start the parachute container for development of various Parachute components.
#
if [ ! -d /opt/parachute ]; then
  echo "This script needs to create the /opt/parachute directory as it does not exist; you"
  echo "may be prompted for echo your password - hopefully you have sudo rights!"
  sudo mkdir -p /opt/parachute
fi

UPONE="${PWD%/*}"
echo Container will have access to $UPONE and /opt/parachute
docker run -it --rm -v /run/host-services/ssh-auth.sock:/ssh-agent -e SSH_AUTH_SOCK="/ssh-agent" -v $UPONE:$UPONE -v /opt/parachute:/opt/parachute -w $PWD --name parachute parachute bash

