#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit

usage() {
  echo >&2 "Usage: $0 [build|demo]

To run the demo you need to build the docker container once using '$0 build'.
Afterwards, you can run '$0 demo'."
  exit 1
}

if [ $# -ne 1 ]
then
  usage
fi

case "$1" in
  build)
    # Check if Nix is installed and try to build the Docker container with Nix.
    # If Nix is not installed or the build failed due to any reason, try to
    # build with Docker.
    ( which nix &>/dev/null && nix-build nix/docker.nix && docker load < result ) ||
      docker build . --tag diffdetective-demo:1.0.0 || echo "Failed to build the docker container." && echo "Docker container sucessfully built."
    ;;
  demo)
    docker run --rm --net=host --volume="$HOME/.Xauthority:/home/user/.Xauthority:rw" -e _JAVA_AWT_WM_NONREPARENTING="$_JAVA_AWT_WM_NONREPARENTING" diffdetective-demo:1.0.0
    ;;
  *)
    usage
    ;;
esac
