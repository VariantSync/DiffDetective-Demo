## Hardware Requirements

None

## Software Requirements

We do not require a certain operating system or prepared environment.
For downloading this demo, we recommend Git (installing Git is explained in [this article](https://github.com/git-guides/install-git)).
The setup is tested on Windows 10, WSL2, Manjaro, and NixOS.

**Executing the demo consists of two steps**: _building the project_ and _running the demo_.
Each step has its own software requirements.


### Requirements for Building

This demo can be built _either_ manually _or_ using Docker _or_ using Nix.
You may choose one of these setups.
If you intend to use this project to develop your own library or application based on DiffDetective, we recommend the manual build.

#### Requirements for Building Manually

This demo is a Maven project based on Java 17.

To build the demo, a [Java development toolkit](https://www.oracle.com/java/technologies/downloads/) of version 17 or higher, and [Maven](https://maven.apache.org/) are required.

The demo has few dependencies, most of which will be handled automatically by Maven.
The dependencies are documented in the Maven build file ([pom.xml](pom.xml)).
The only dependency that must be installed manually is our tool and library DiffDetective, which is also a Java Maven project.
Installing DiffDetective follows the default maven workflow and is explained on the [DiffDetective website](https://variantsync.github.io/DiffDetective/) and README.

#### Requirements for Building with Docker

How to install Docker depends on your operating system:

- _Windows or Mac_: You can find download and installation instructions [here](https://www.docker.com/get-started).
- _Linux Distributions_: How to install Docker on your system, depends on your distribution. The chances are high that Docker is part of your distributions package database.
  Docker's [documentation](https://docs.docker.com/engine/install/) contains instructions for common distributions.

#### Requirements for Building with Nix

How to install Nix, also depends on your operating system.
Head to the [NixOS website](https://nixos.org/download/) and follow the installation instructions for your system.
Follow the download instructions for `Nix: the package manager`, not `NixOS: the Linux distribution`!

Note that Nix is not available for Windows.
Instead, you can use Nix from within Windows Subsystem for Linux (WSL2).
However, we do not recommend using Nix on Windows, except if you are already familiar with WSL2, Nix, and XServers.
We recommend using Docker or a manual setup instead.
Running the Demo from within WSL2 requires an XServer.
We recommend [VcXsrv](https://sourceforge.net/projects/vcxsrv/).

### Requirements for Running

To run the demo, a [Java development toolkit](https://www.oracle.com/java/technologies/downloads/) of version 17 or higher is required.

As an _optional_ dependency, running the demo uses graphviz.
You may find installation instructions for graphviz [here](https://graphviz.org/download/).
You may run the demo without graphviz, in which case the demo will print an error to the terminal and DiffDetective cannot compute a layout for visualizing graphs.
In this case, the GUI may appear differently as in the screencast (see _Expected Output_ section in [INSTALL.md](INSTALL.md)).

> We also provide a nix and docker setup for running the demo, too. However, these setups are fragile because the demo launches a graphical user interface which may cause errors.
> Hence, you can also run the demo without installing Java or graphviz.
> We hence recommend to run the demo manually with Java.