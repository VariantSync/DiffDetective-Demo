## Hardware Requirements

None

## Software Requirements

> This demo can be run with Docker or Nix. If you intend to use one of them, you may skip to the last section in this document. 

We do not require a certain operating system or prepared environment.
For downloading this demo, we recommend Git (installing Git is explained in [this article](https://github.com/git-guides/install-git)).
The setup is tested on Windows 10, WSL2, Manjaro, Ubuntu, and MacOS Monterey.

### Toolchain
This demo is a Maven project based on Java 17. Thus, it requires a [Java development toolkit](https://www.oracle.com/java/technologies/downloads/) of version 17 or higher, and [Maven](https://maven.apache.org/). 

### Java Dependencies
The demo has few dependencies, most of which will be handled automatically by Maven.
The dependencies are documented in the Maven build file ([pom.xml](pom.xml)).
The only dependency that must be installed manually is our tool and library DiffDetective, which is also a Java Maven project.
Installing DiffDetective follows the default maven workflow and is explained on the [DiffDetective website](https://variantsync.github.io/DiffDetective/) and README.

## Virtualization: Docker or Nix
For easy replication, this demo also comes with a Nix package and a Docker container, which can be used on any system supporting Nix or Docker, respectively.
The Nix and Docker setup will take care of all requirements and dependencies (including DiffDetective) and will build the demo to a single runnable JAR file.
_Note_: Nix and Docker are neither required by the demo nor DiffDetective! They only serve to ease the setup for you. You may use either Nix or Docker but you do not need both.

How to install Docker depends on your operating system:

- _Windows or Mac_: You can find download and installation instructions [here](https://www.docker.com/get-started).
- _Linux Distributions_: How to install Docker on your system, depends on your distribution. The chances are high that Docker is part of your distributions package database.
  Docker's [documentation](https://docs.docker.com/engine/install/) contains instructions for common distributions.

How to install Nix, also depends on your operating system.
Head to the [NixOS website](https://nixos.org/download/) and follow the installation instructions for your system.
Follow the download instructions for `Nix: the package manager`, not `NixOS: the Linux distribution`!
