# DiffDetective-Demo

A small demonstration of [DiffDetective](https://github.com/VariantSync/DiffDetective).
The idea of this demo is to serve as an example for how to use DiffDetective, as well as a template project for you to clone and adapt as a quickstart for developing with DiffDetective.

There is a screencast available on YouTube, guiding you through the demo's setup with Maven in IntelliJ and how to implement variability-aware differencing and analyses of Git histories:

[![DiffDetective Demonstration](docs/yt_thumbnail.png)](https://www.youtube.com/watch?v=q6ight5EDQY)

## Setup

The demo is a Java Maven project, which includes DiffDetective as a library.
You may run the demo manually, or by using Nix or Docker.
The manual setup enables you to use DiffDetective in any of your own Maven projects.
The Nix and Docker setups just build the demo for you to run it.

Software requirements are documented in the [REQUIREMENTS.md](REQUIREMENTS.md) file (there are no specific hardware requirements).
Basically, you will have to install Java and Maven, or alternatively Nix or Docker.

Installation instructions are documented in the [INSTALL.md](INSTALL.md) file.

