# DiffDetective-Demo
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.11095172.svg)](https://doi.org/10.5281/zenodo.11095172)
[![License](https://img.shields.io/badge/License-GNU%20LGPLv3-blue)](LICENSE.LGPL3)
[![Preprint](https://img.shields.io/badge/Preprint-Read-purple)][Preprint]

<img padding="10" align="right" src="https://www.acm.org/binaries/content/gallery/acm/publications/artifact-review-v1_1-badges/artifacts_evaluated_reusable_v1_1.png" alt="ACM Artifacts Evaluated Reusable" width="114" height="113"/>

This is a small demonstration of [DiffDetective](https://github.com/VariantSync/DiffDetective).
The purpose of this demo is to provide an example of how to use DiffDetective and to serve as a template project for you to clone and adapt as a quickstart for developing with DiffDetective.

There is a screencast available on YouTube, guiding you through the demo's setup with Maven in IntelliJ and how to implement variability-aware differencing and analyses of Git histories:

[![DiffDetective Demonstration](docs/yt_thumbnail.png)](https://www.youtube.com/watch?v=q6ight5EDQY)

To learn more about DiffDetective you may either head to it's [website][DiffDetectiveWebsite] or read our accompanying paper (a preprint is available [here][Preprint]):

> P. M. Bittner, A. Schultheiß, B. Moosherr, T. Kehrer, T. Thüm. _Variability-Aware Differencing with DiffDetective_. Demonstrations at International Conference on the Foundations of Software Engineering 2024, ⭐ [Best Demo Paper](https://2024.esec-fse.org/track/fse-2024-demonstrations?#Awards) ⭐, ACM, New York, NY, July 2024

## Setup

The demo is a Java Maven project, which includes DiffDetective as a library.

Software requirements are documented in the [REQUIREMENTS.md](REQUIREMENTS.md) file (there are no specific hardware requirements).
Basically, you will have to install Java and Maven, or alternatively Nix or Docker.

Installation instructions are documented in the [INSTALL.md](INSTALL.md) file.

[Preprint]: https://github.com/SoftVarE-Group/Papers/raw/main/2024/2024-FSE-Bittner.pdf
[DiffDetectiveWebsite]: https://variantsync.github.io/DiffDetective/
