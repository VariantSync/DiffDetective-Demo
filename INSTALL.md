# Setup Instructions

You may run the demo manually, or by using Nix or Docker.
The manual setup enables you to use DiffDetective in any of your own Maven projects.
The Nix and Docker setups just build the demo for you to run it.
Windows users should _not_ use the Nix setup except if they have experience with WSL2, XServers, and Nix (see [REQUIREMENTS.md](REQUIREMENTS.md)).

In case you encounter problems, you may have a look at the _Troubleshooting_ section at the bottom of this file.

## Manual Setup

Check the requirements needed for the manual setup in the [REQUIREMENTS.md](REQUIREMENTS.md) file.

Follow the setup instructions on the [DiffDetective website](https://variantsync.github.io/DiffDetective/) for building and installing DiffDetective with Maven (and _not_ with Nix).
These instructions make you clone the repo and install it.
Afterward, come back here and you should be ready to go.

To run the demo, you can do so via an IDE or terminal.
In our screencast, we show how to build and run the Demo in IntelliJ.
Alternatively, here we show how to build and run the demo on the command line.

Open a terminal and navigate to the top level of this repository.
You can then build the demo running the following Maven command:
```shell
mvn package
```
Afterward, the jar files can be found in the `target` directory as the build output.
To run the demo, invoke `java` on the jar file that includes any dependencies:
```shell
java -jar target/diffdetectivedemo-1.0.0-jar-with-dependencies.jar
```
The expected output and behavior of the jar file is explained below in the section _Expected Output_.

## Docker Setup

Check the requirements needed for the Docker setup in the [REQUIREMENTS.md](REQUIREMENTS.md) file.

### Start the docker deamon

- **On Linux**: Typically, the docker deamon runs automatically, so there is nothing to do. Otherwise, run `sudo systemctl start docker`.
- **On Windows**: Open the search bar using the 'Windows Key' and search for 'Docker' or 'Docker Desktop'.

More detailed instructions on starting the deamon are given [here](https://docs.docker.com/config/daemon/start/) on the docker website.

### Docker Setup on Windows

Open a terminal (preferably Windows PowerShell) and navigate to the repository's directory (the directory containing this `INSTALL.md`).
Then, create the docker image
```shell
docker build -t diffdetective-demo .
```
You can verify that the image was created successfully by running
```shell
docker images
```
and checking that an image called `diffdetective-demo` is listed.
You can run the image and thus the demo with the following command:
```shell
docker run --net=host -e DISPLAY=host.docker.internal:0 -t diffdetective-demo
```
You may get some font errors, which you can ignore (see Troubleshooting below).
The parameters `--net=host` and `-e DISPLAY=host.docker.internal:0` are required to launch graphical user interfaces from within Docker.

### Docker Setup on Linux

> You might require elevated privileges to execute Docker commands (e.g., `sudo ./docker.sh build` or adding the user to the `docker` or `wheel` group).
> See Docker's [post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/) for more information.

> It is best to install required software (e.g., Docker, Maven) using your distro's package manager if it is available.

You can use the `docker.sh` script to build and execute the Demo using [Docker](https://www.docker.com/get-started) as described below.

#### Setup
Clone and navigate to this repository (the directory containing this `INSTALL.md`).
Then, simply build the image using the provided script:
```shell
./docker.sh build
```

This will automatically build the Docker container using Nix if Nix is installed on your system.

#### Execution
Once the image has been build, you can start the demo with
```shell
./docker.sh demo
```

## Nix Setup

Nix can be used to reproducibly build both, a standalone derivation and a docker container.
Nix aids in reproducible builds whereas Docker aids in reproducible execution.

To use Nix, you need to have [Nix](https://nixos.org/download/) installed on your system.
See [REQUIREMENTS.md](REQUIREMENTS.md) for instructions on how to install Nix and optionally also Docker.

### Standalone Build

> Notice for Windows users:
> You must run the following commands from within a WSL2 terminal.
> Also, make sure to clone this repository to a directory within WSL and _not_ to a Windows directory.
> Otherwise, the Nix setup might fail due to incompatibilities with the file system.
> Moreover, if you would like to have access to the demo's GUI, you need an XServer installed (see [REQUIREMENTS.md](REQUIREMENTS.md)).

If you have flakes enabled, you can just use
```shell
nix run github:VariantSync/DiffDetective-Demo
```

Otherwise, clone and navigate to this repository.
Then simply build and run the Demo using
```shell
nix-build
./result/bin/DiffDetective-Demo
```

### Using a Docker Image

If you have Nix installed, the `docker.sh` script will automatically build this demo using Nix.
Hence, the instructions are the same as for docker:
Clone and navigate to this repository and execute the following:
```shell
./docker.sh build
./docker.sh demo
```


## Expected Output

The expected output is close to the output shown at the end of the [screencast](https://www.youtube.com/watch?v=q6ight5EDQY).
When you run the demo, a text-based diff should be printed to the terminal, followed by four windows opening up:
![Screenshot of expected output](docs/expected_output_1.png).
After closing these windows (use `ESC` key for fast closing), there should be another four windows opening with the same trees and diffs but not in the simplified "foo/bar" version.
After closing these windows, a small example analysis of the xterm repository should run in the terminal.
The analysis should take about 30s-5min, and its output to terminal should look similar to this:
```
2024-04-27 11:40:46 INFO    [AnalysisRunner.run] Reading and cloning git repositories from/to: data\repos
2024-04-27 11:40:46 INFO    [AnalysisRunner.run] Writing output to: data\output
2024-04-27 11:40:46 INFO    [AnalysisRunner.run] Loading datasets file: data\demo-dataset.md
2024-04-27 11:40:46 INFO    [AnalysisRunner.run] Performing validation on the following repositories:
2024-04-27 11:40:46 INFO    [AnalysisRunner.run]   - xterm from https://github.com/DiffDetective/xterm.git
2024-04-27 11:40:46 INFO    [AnalysisRunner.run] Preloading repositories:
2024-04-27 11:40:46 INFO    [Repository.load] Loading git at data\repos\xterm ...
2024-04-27 11:40:47 INFO    [Analysis.forEachRepository]  === Begin Processing xterm ===
2024-04-27 11:40:47 INFO    [Analysis.forEachCommit] >>> Scheduling asynchronous analysis on 8 threads.
2024-04-27 11:40:47 INFO    [Analysis.forEachCommit] <<< done in 0.222s
2024-04-27 11:40:47 INFO    [Analysis.forEachCommit] >>> Run Analysis
2024-04-27 11:41:21 INFO    [DemoAnalysis.endBatch] Batch done: 11 commits analyzed
2024-04-27 11:41:38 INFO    [DemoAnalysis.endBatch] Batch done: 20 commits analyzed
2024-04-27 11:41:39 INFO    [DemoAnalysis.endBatch] Batch done: 20 commits analyzed
2024-04-27 11:41:39 INFO    [DemoAnalysis.endBatch] Batch done: 20 commits analyzed
2024-04-27 11:41:40 INFO    [DemoAnalysis.endBatch] Batch done: 20 commits analyzed
2024-04-27 11:41:40 INFO    [DemoAnalysis.endBatch] Batch done: 20 commits analyzed
2024-04-27 11:41:40 INFO    [Analysis.forEachCommit] <<< done in 53.09s
2024-04-27 11:41:40 INFO    [Analysis.exportMetadataToFile] Metadata:
    analysis: my analysis
    repository: xterm
    big diffs: 188
    runtime with multithreading in seconds: 53.09
    total commits: 111

2024-04-27 11:41:40 INFO    [Analysis.forEachRepository]  === End Processing xterm after 53.379s ===
2024-04-27 11:41:40 INFO    [AnalysisRunner.run] Done
```
The output files of the analysis should be located at [data/output](data/output).

## Troubleshooting

### ERROR [VariationDiffApp.layoutNodes] java.io.IOException: Cannot run program "dot": error=2, No such file or directory

You may choose to ignore this error. This happens when `dot` is not installed on your system. `dot` is shipped with graphviz. To fix, please install `graphviz` (see [REQUIREMENTS.md](REQUIREMENTS.md)). The demo can run without `graphviz` though (but then all graph nodes in the GUI are located at the same point).

### Expected Output: There is only a single node in the shown graphs / All nodes are at the same location.

When graphviz is not installed, DiffDetective cannot compute a layout for the graph nodes in the GUI. To fix, please install `graphviz` (see [REQUIREMENTS.md](REQUIREMENTS.md)).

### Error during `nix-build` on Windows (11)

When you encounter the following error:
```
Running phase: buildPhase
/nix/store/kv5wkk7xgc8paw9azshzlmxraffqcg0i-stdenv-linux/setup: line 114: $'\r': command not found
/nix/store/kv5wkk7xgc8paw9azshzlmxraffqcg0i-stdenv-linux/setup: line 131: pop_var_context: head of shell_variables not a function context
error: builder for '/nix/store/y5qjl7ly9zmmkyp6gi2cpzszn84q8a3a-DiffDetective-Demo-1.0.0-maven-deps.drv' failed with exit code 127
error: 1 dependencies of derivation '/nix/store/3hyzjh1jfjaac2vgi5zj7mhw5cvr0gym-DiffDetective-Demo-1.0.0.drv' failed to build
```
you probably downloaded the demo to a Windows directory but tried to use the Nix setup from WSL2.
Please clone the demo to a directory within WSL2.
For Windows users though, we recommend to use Docker instead of Nix.

### Docker says my image was built 54 years ago.

That is in purpose. Timestamps are not reproducible, so we fixed the timestamp to the UNIX timestamp 1.

### Fontconfig error: Cannot load default config file: No such file: (null)

This is a warning that you may ignore. It means that some fonts requested by the GUI could not be found on your system. As long as you see text in your GUI, this is fine.

### error: a 'x86_64-linux' with features {kvm} is required to build '/nix/store/sw5bbvy20jy61r6jh39l6qxvn9jv1mx0-docker-layer-DiffDetective-Demo.drv', but I am a 'x86_64-linux' with features {benchmark, big-parallel, nixos-test, uid-range}

This error is raised by Nix when there is no hardware support for virtualization.
In this case, our build script falls back to Docker.
It is likely that this fall back failed, which typically happens when Docker could not be started.
To fix, start the docker daemon as it was probably not running.
