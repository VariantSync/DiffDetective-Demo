#!/bin/bash

IMAGE_NAME="diff-detective-demo"

function build() {
	docker build -t $IMAGE_NAME .
}

function demo() {
	docker run --rm $IMAGE_NAME
}

case "$1" in
build)
	build
	;;
demo)
	demo
	;;
*)
	echo "Usage: $0 {build|bash|demo}"
	echo "build: build the image"
	echo "demo: execute the demo to view the final results"
	exit 1
	;;
esac
