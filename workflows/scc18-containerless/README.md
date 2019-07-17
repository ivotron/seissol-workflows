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

  * **`checkout master branch`**. Points the `submodules/seissol` submodule
    to its master branch.

  * **`install dependencies`**: Installs dependencies (Scons,
    HDF5, NetCDF, LibXSMM, and PSpaMM) in `./install`.

  * **`build`**: Builds SeisSol using the parameters specified in
    [`compile.sh`](./scripts/compile.sh) (enabling HDF5, NetCDF support).

  * **`download input data`**: Downloads the input files from
    [Zenodo][zenodo] and saves them in `./execution`.

  * **`execute`**: Prepares the execution of the simulation by
    creating an `./execution` folder that contains the input data,
    input parameters and an `execution/output` folder where the output
    files are stored.

## Execution

This workflow runs on the host machine environment and can be executed with the [Popper
CLI tool][popper]. For a version of this workflow in a containerized
environment, see [here](../scc18). The
following executes this workflow:

```bash
git clone --recursive https://github.com/popperized/seissol-workflows
cd seissol-workflows/workflow/scc18-containerless

popper run
```

> **NOTE**: The `--recursive` flag is required in order to download
> the <https://github.com/SeisSol/SeisSol> project, which is a
> submodule of this repository.


Sample output as written to the `execution/output/stdout.txt` file
(trimmed to only show end of execution):

```
 3820 Wed Jul 17 02:55:32, Info:  Time wave field writer backend: 4.34847 (min: 2.52913, max: 6.32426)
 3821 Wed Jul 17 02:55:32, Info:  Time wave field writer frontend: 4.39415 (min: 2.59996, max: 6.36791)
 3822 Wed Jul 17 02:55:32, Info:  Time fault writer backend: 1.75809 (min: 1.5905, max: 1.87951)
 3823 Wed Jul 17 02:55:32, Info:  Time fault writer frontend: 1.75871 (min: 1.59073, max: 1.87974)
 3824 Wed Jul 17 02:55:32, Info:  Time free surface writer backend: 0.576579 (min: 0.563705, max: 0.585877)
 3825  Enter closeGalerkin...
 3826 Rank:        0 | Info    | closeGalerkin successful
 3827 Rank:        0 | Info    | <--------------------------------------------------------->
 3828 Rank:        0 | Info    | <     close_SeisSol successfully finished                 >
 3829 Rank:        0 | Info    | <--------------------------------------------------------->
 3830 Rank:        0 | Info    |
 3831 Rank:        0 | Info    |
 3832 Rank:        0 | Info    | ____________  Program finished without errors  ____________
 3833 Rank:        0 | Info    |
 3834 Rank:        0 | Info    |
 3835 Wed Jul 17 02:55:32, Info:  SeisSol done. Goodbye.
```

[scc18]: http://www.studentclustercompetition.us/2018/applications.html
[seissol-paper]: https://dl.acm.org/citation.cfm?id=3126948
[seissol]: https://github.com/seissol/seissol
[zenodo]: https://zenodo.org/record/439946
[popper]: https://github.com/systemslab/popper

