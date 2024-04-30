#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit

if command -v nix-build &>/dev/null
then
  echo "Using Nix to build the DiffDetective demo jar."
  nix-build &&
  cp -f result/share/java/DiffDetective-Demo.jar . &&
  chmod u+w DiffDetective-Demo.jar &&
  echo &&
  echo "The jar has been built successfully. You can find it in $(realpath DiffDetective-Demo.jar)" &&
  echo "You might want to remove the 'result' link ('rm result') to allow the Nix garbage collector to reclaim some space."
elif command -v docker &>/dev/null
then
  echo "Using Docker to build the DiffDetective demo jar."

  root=0
  if ! groups | grep -q docker
  then
    if [ "$(id -u)" -ne 0 ]
    then
      echo >&2 "You don't seem to be able to run Docker as your user. Please start this script as root (e.g., using 'sudo') or ensure you are a member of the docker group."
      exit 2
    fi
  fi

  if ! docker version &>/dev/null
  then
    echo >&2 "Docker isn't running. You need to start the docker engine first."
    echo >&2 "On most Linux distributions you can do so using 'systemctl start docker'."
    exit 3
  fi

  docker build . --tag diffdetective-demo:1.0.0 &&
  docker run --volume "$PWD:/output:rw" diffdetective-demo:1.0.0 /bin/cp /DiffDetective/share/java/DiffDetective-Demo.jar /output

  if [ "$?" -eq 0 ]
  then
    echo
    echo "The jar has been built successfully. You can find it in $(realpath DiffDetective-Demo.jar)"
    echo "You might want to remove the Docker image ('docker image rm diffdetective-demo:1.0.0')."

    if [ "$(id -u)" -eq 0 ]
    then
      echo "You might want to change the owner of the jar ('chown username:group DiffDetective-Demo.jar') because it's current owner is root."
    fi
  fi
else
  echo "Neither Nix nor Docker are installed. You need to compile the jar for yourselves. See INSTALL.md for instructions."
fi
