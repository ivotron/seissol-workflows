# SeisSol TPV33 Benchmark

This workflow automates the [_A First Example_][tutorial] tutorial 
from SeisSol's official documentation, which corresponds to the 
execution of the [SCEC TPV33 benchmark][scec].

## Workflow

The workflow defined in the [`main.workflow`](./main.workflow) file 
consists of four actions:

  * **`remove previous builds`**. Deletes any previously-compiled 
    binaries to avoid any confusion while running the workflow.

  * **`build`**: Compiles SeisSol and generates the executable. The 
    build environment is defined in the accompanying 
    [`actions/seissol`](./actions/seissol) action folder, specifically 
    in the [`Dockerfile`](./actions/seissol/Dockerfile).

  * **`download data and parameters`**: Downloads the data and 
    parameter files required to execute the benchmark. These are saved 
    in an `execution/` folder.

  * **`execute`**: Runs the benchmark with the specified parameters:
      * `OMP_NUM_THREADS`. Number of OpenMP threads to use.
      * `MPI_NUM_PROCESSES`. Number of MPI processes to use.
      * `SEISSOL_END_TIME`. Abort condition for the simulation (real 
        number).

## Execution

This workflow runs in a container runtime ([Docker][docker], 
[Singularity][singularity], etc.) and can be executed with the [Popper 
CLI tool][popper]. The following executes this workflow:

```bash
git clone --recursive https://github.com/popperized/seissol-workflows

cd seissol-workflows/workflow/tpv33

popper run
```

Sample output (trimmed to only show end of execution):

```
Mon Jul 08 06:18:25, Info:  Total time spent in compute kernels: 10.3099
Mon Jul 08 06:18:25, Info:  Total   measured HW-GFLOP:  0
Mon Jul 08 06:18:25, Info:  Total calculated HW-GFLOP:  11.9672
Mon Jul 08 06:18:25, Info:  Total calculated NZ-GFLOP:  7.21896
Mon Jul 08 06:18:25, Info:  WP calculated HW-GFLOP:  11.6114
Mon Jul 08 06:18:25, Info:  WP calculated NZ-GFLOP:  6.91263
Mon Jul 08 06:18:25, Info:  DR calculated HW-GFLOP:  0.355841
Mon Jul 08 06:18:25, Info:  DR calculated NZ-GFLOP:  0.306333
Mon Jul 08 06:18:25, Info:  PL calculated HW-GFLOP:  0
Mon Jul 08 06:18:25, Info:  PL calculated NZ-GFLOP:  0
Rank:        0 | Info    | total number of performed time steps:            0
Rank:        0 | Info    | final time of the simulation:    1.0000000000000001E-005
Rank:        0 | Info    | <--------------------------------------------------------->
Rank:        0 | Info    | <--------------------------------------------------------->
Rank:        0 | Info    | <     calc_SeisSol successfully finished                  >
Rank:        0 | Info    | <--------------------------------------------------------->
Rank:        0 | Info    | <--------------------------------------------------------->
Rank:        0 | Info    | <     Start close_SeisSol ...                             >
Rank:        0 | Info    | <--------------------------------------------------------->
Mon Jul 08 06:18:25, Info:  Time wave field writer backend: 0.871728 (min: 0.871728, max: 0.871728)
Mon Jul 08 06:18:25, Info:  Time wave field writer frontend: 1.35258 (min: 1.35258, max: 1.35258)
Mon Jul 08 06:18:25, Info:  Time fault writer backend: 0.220198 (min: 0.220198, max: 0.220198)
Mon Jul 08 06:18:25, Info:  Time fault writer frontend: 0.22035 (min: 0.22035, max: 0.22035)
Mon Jul 08 06:18:25, Info:  Time free surface writer backend: 0.0360623 (min: 0.0360623, max: 0.0360623)
Mon Jul 08 06:18:25, Info:  Time free surface writer frontend: 0.0361474 (min: 0.0361474, max: 0.0361474)
Rank:        0 | Info    | Enter closeGalerkin...
Rank:        0 | Info    | closeGalerkin successful
Rank:        0 | Info    | <--------------------------------------------------------->
Rank:        0 | Info    | <     close_SeisSol successfully finished                 >
Rank:        0 | Info    | <--------------------------------------------------------->
Rank:        0 | Info    |
Rank:        0 | Info    |
Rank:        0 | Info    | ____________  Program finished without errors  ____________
Rank:        0 | Info    |
Rank:        0 | Info    |
Mon Jul 08 06:18:25, Info:  SeisSol done. Goodbye.
Workflow finished successfully.
```

[tutorial]: https://seissol.readthedocs.io/en/latest/a-first-example.html#a-first-example
[scec]: http://scecdata.usc.edu/cvws/tpv33docs.html
[docker]: https://get.docker.com
[popper]: https://github.com/systemslab/popper
[singularity]: https://github.com/sylabs/singularity
