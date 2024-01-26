# DiffDetective-Demo

## Hints for Linux users
The following hints apply for most Linux users:
> You might require elevated privileges to execute Docker commands (e.g., `sudo ./docker.sh build` or adding the user to the `docker` or `wheel` group).
> See the [post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/) for more information.

> It is best to install required software (e.g., Docker, Maven) using your distro's package manager if it is available.


## Replaying the Demo with Docker
You can use the `docker.sh` script to build and execute the Demo using [Docker](https://www.docker.com/get-started/).

### Required software
- [Docker](https://www.docker.com/get-started/)

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

## Replaying the Demo locally

### Required software
- [Maven](https://maven.apache.org/) which is also integrated in [Eclipse](https://projects.eclipse.org/projects/technology.m2e) and [Intellij](https://www.jetbrains.com/help/idea/maven-support.html)
- [JDK](https://www.oracle.com/java/technologies/downloads/) 16 or newer