# DiffDetective-Demo

A small demonstration of [DiffDetective](https://github.com/VariantSync/DiffDetective). The demo is a Java maven project, which include DiffDetective as a library.
You may run the demo manually, or by using Docker.
The manual setup enables you to use DiffDetective in any of your maven projects.
The Docker setup just runs the demo.

## Manual Setup

Required software:
- [Maven](https://maven.apache.org/) which is also integrated in [Eclipse](https://projects.eclipse.org/projects/technology.m2e) and [Intellij](https://www.jetbrains.com/help/idea/maven-support.html)
- [JDK](https://www.oracle.com/java/technologies/downloads/) 16 or newer

Follow the setup instructions on the [DiffDetective website](https://variantsync.github.io/DiffDetective/).
These instructions make you clone, the repo and install it.
Afterward, come back here and you should be ready to go.

If you want an empty demo template project to implement the demo yourself, or to use for other purposes, you may
switch to the `empty` branch.
The `main` branch contains the full demo source code, instead.

## Docker Setup

You can use the `docker.sh` script to build and execute the Demo using [Docker](https://www.docker.com/get-started).

### Required software
- [Docker](https://www.docker.com/get-started/)

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
