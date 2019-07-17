# SCC18 Workflow

This workflow automates the execution of the [SC18 Student Cluster 
Competition Challenge][scc18] which consists of a high-resolution 
simulation of the 2004 Sumatra-Andaman earthquake using 
[SeisSol][seissol]. Refer to the [_"Extreme scale multi-physics 
simulations of the tsunamigenic 2004 sumatra megathrust 
earthquake"_][seissol-paper] article for more details.

## Workflow

The [workflow](./main.workflow) consists of six actions:

  * **`remove previous builds`**. Deletes any previously-compiled 
    binaries to avoid any confusion while running the workflow.

  * **`install dependencies`**: Installs dependencies (OpenMPI, 
    NetCDF, HDF5, LibXSMM, and CMake) via [Spack][spack].

  * **`install scons`**: Installs the SCons build system that the 
    SeisSol project uses.

  * **`build`**: Builds SeisSol using the parameters specified in the 
    workflow file (enabling HDF5, NetCDF support).

  * **`download input data`**: Downloads the input files from 
    [Zenodo][zenodo] using a [Zenodo action][zenodo-gha] and saves 
    them in `./execution`.

  * **`execute`**: Prepares the execution of the simulation by 
    creating an `./execution` folder that contains the input data, 
    input parameters and an `execution/output` folder where the output 
    files are stored.

## Execution

This workflow runs in a container runtime ([Docker][docker], 
[Singularity][singularity], etc.) and can be executed with the [Popper 
CLI tool][popper]. For a version of this workflow in a 
non-containerized environment, see [here](../scc18-containerless). The 
following executes this workflow:

```bash
git clone --recursive https://github.com/popperized/seissol-workflows
cd seissol-workflows/workflow/scc18

popper run
```

> **NOTE**: The `--recursive` flag is required in order to download 
> the <https://github.com/SeisSol/SeisSol> project, which is a 
> submodule of this repository.

To run in Singularity:

```bash
popper run --runtime singularity
```

[scc18]: http://www.studentclustercompetition.us/2018/applications.html
[seissol-paper]: https://dl.acm.org/citation.cfm?id=3126948
[spack]: https://github.com/popperized/spack
[seissol]: https://github.com/seissol/seissol
[zenodo]: https://zenodo.org/record/439946
[zenodo-gha]: https://github.com/popperized/zenodo
