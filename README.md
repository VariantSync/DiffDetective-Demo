# DiffDetective-Demo
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.11095172.svg)](https://doi.org/10.5281/zenodo.11095172)
[![License](https://img.shields.io/badge/License-GNU%20LGPLv3-blue)](LICENSE.LGPL3)

This is a small demonstration of [DiffDetective](https://github.com/VariantSync/DiffDetective).
The purpose of this demo is to provide an example of how to use DiffDetective and to serve as a template project for you to clone and adapt as a quickstart for developing with DiffDetective.

There is a screencast available on YouTube, guiding you through the demo's setup with Maven in IntelliJ and how to implement variability-aware differencing and analyses of Git histories:

[![DiffDetective Demonstration](docs/yt_thumbnail.png)](https://www.youtube.com/watch?v=q6ight5EDQY)

This demo, also manifests the artifact submission for our paper _Variability-Aware Differencing with DiffDetective_, accepted at the FSE'24 demonstrations track.
A preprint of the paper is available as part of this repository, [here](Variability-Aware%20Differencing%20with%20DiffDetective.pdf).
Our application for artifact badges can be found in the [STATUS.md](STATUS.md) file.
Please note that this submission is _not_ a replication package of an empirical study (e.g., tool evaluation).
Instead, this repository is a template project with examples for how to use DiffDetective as a library (i.e., a demo).

## Setup

The demo is a Java Maven project, which includes DiffDetective as a library.

Software requirements are documented in the [REQUIREMENTS.md](REQUIREMENTS.md) file (there are no specific hardware requirements).
Basically, you will have to install Java and Maven, or alternatively Nix or Docker.

Installation instructions are documented in the [INSTALL.md](INSTALL.md) file.
