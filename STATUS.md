# STATUS
## Overview
The artifact for our paper _Variability Aware Differencing with DiffDetective_ consists of two parts:

1. **DiffDetective-Demo**: This repository contains a demonstration of DiffDetective. The idea of this demo is to serve as an example for how to use DiffDetective, as well as a template project to clone and adapt as a quickstart for developing with DiffDetective.
2. **DiffDetective**: Our Java library that implements variability-aware differencing as well as various analyses. 
    DiffDetective also contains replication packages of previous studies.
    DiffDetective is hosted in its own repository on [Github](https://github.com/VariantSync/DiffDetective)

## Claims
We claim the following badges for our artifact:

- **Availability**: This demo as well as DiffDetective are publicly available on Github under open-source licenses (LGPL3). Both repositories are archived at the state of this submission on Zenodo.
- **Functional**: Our artifact is functional because it satisfies the following requirements:
  - **Documented**: The demo as well as DiffDetective are documented with a README file. Both Java code bases are documented and DiffDetective's documentation is available online ([here][javadoc]).
  - **Consistent**: DiffDetective is the tool presented in our paper. The demo (this repository) replicates the motivating example from Figure 1 in the paper (Section 2). The case studies presented in Section 3 are contained within DiffDetective as replication packages and are documented in DiffDetective's README file.
   DiffDetective also contains the implementations of most algorithms and methods developed throughout these case studies (e.g., edit classification, view generation, tree differencing). (The case study on benchmark generation is part of the [VEVOS project](https://github.com/VariantSync/VEVOS_Extraction), documented externally).
  - **Complete**: The replication packages are complete. DiffDetective contains the replication packages of past studies if applicable. The demo replicates the tool overview from our paper and more.
  - **Exercisable**: The demo is a runnable Java project. DiffDetective is exercised as a library in the demo and in replication packages of past studies.
  - **Evidence for Verification and Validation**: _Does not apply here because this submission is part of a tool demo, not an empirical study. Past case studies based on DiffDetective received functional badges though, and hence tick this box._
- **Reusable**: In addition to the functional badge, we also apply for the reusable badge. Our replication package significantly exceeds minimal functionality for the following reasons:
  - DiffDetective is designed as a reusable Java library, and has been reused in several studies in the past. DiffDetective's functionality goes beyond the mere replication of experiments, including, but not limited to, variability-aware differencing via text-based or tree-based differencing, obtaining variation diffs for certain patches and commits, graphical diff inspection, classifying edits in variation diffs, defining custom classifications, view generation, rendering, traversing, and transforming variation diffs, various de-/serialization methods, and running analyses for the git histories of C preprocessor-based software product lines.
  - The demo serves as an example project for setting up and using the library. 
  Hence, it fosters the reuse of the library in further projects. The demo also comes with a [screencast available on YouTube][screencast], covering the setup of DiffDetective and the demo, and a coding tutorial.
  - DiffDetective's README file documents an overview on all respective papers, student theses, and associated replication packages. These replication packages are regularly updated with the latest releases of DiffDetective. Hence, past studies can be replicated either (1) via the archives of the initial versions, or (2) via the updated replication packages (e.g., benefiting from performance improvements).
  - For easy access to the datasets used in past case studies, and to foster exact replications of respective experiments, we provide forks of all 44 dataset repositories, frozen at their state around February 2022. These forks are grouped on a dedicated [Github account][datasets]. The dataset of these repositories can be easily customized and loaded into DiffDetective by using the dataset markdown files provided with DiffDetective.
  - DiffDetective also contains the appendices of the paper's of the respective case studies. 
  - Lastly, DiffDetective contains a small Haskell project with formal specifications of variation trees and diffs, the central data structures for variability-aware differencing.

[javadoc]: https://variantsync.github.io/DiffDetective/docs/javadoc/
[datasets]: https://github.com/DiffDetective
[screencast]: https://www.youtube.com/watch?v=q6ight5EDQY
