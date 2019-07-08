# SeisSol TPV33 Benchmark

This example workflow follows the [_A First Example_][tutorial] 
tutorial from SeisSol's official documentation, which corresponds to 
the [SCEC TPV33 benchmark][scec].

## Workflow

The workflow defined in [`main.workflow`](./main.workflow)) consists 
of four actions:

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

[tutorial]: https://seissol.readthedocs.io/en/latest/a-first-example.html#a-first-example
[scec]: http://scecdata.usc.edu/cvws/tpv33docs.html
