# Setup Instruction

You may run the demo manually, or by using Nix or Docker.
The manual setup enables you to use DiffDetective in any of your own Maven projects.
The Nix and Docker setups just build the demo for you to run it.

## Manual Setup

Check the requirements needed for the manual setup in the [REQUIREMENTS.md](REQUIREMENTS.md) file.

Follow the setup instructions on the [DiffDetective website](https://variantsync.github.io/DiffDetective/).
These instructions make you clone, the repo and install it.
Afterward, come back here and you should be ready to go.

If you want an empty demo template project to implement the demo yourself, or to use for other purposes, you may
switch to the `empty` branch.
The `main` branch contains the full demo source code, instead.

## Docker Setup

Check the requirements needed for the manual setup in the [REQUIREMENTS.md](REQUIREMENTS.md) file.

You can use the `docker.sh` script to build and execute the Demo using [Docker](https://www.docker.com/get-started).

### Required software

### Hints for Linux users
The following hints apply for most Linux users:
> You might require elevated privileges to execute Docker commands (e.g., `sudo ./docker.sh build` or adding the user to the `docker` or `wheel` group).
> See the [post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/) for more information.

> It is best to install required software (e.g., Docker, Maven) using your distro's package manager if it is available.

### Setup
Simply build the image using the provided script:
```shell
./docker.sh build 
```

### Execution
Once the image has been build, you can start the demo with
```shell
./docker.sh demo
```

## Nix Setup