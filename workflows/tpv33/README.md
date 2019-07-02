# SeisSol First Example

This example workflow follows [this](https://seissol.readthedocs.io/en/latest/a-first-example.html#a-first-example) tutorial.


## Workflow

The workflow consists of four actions:
  
  * `build`: Compiles seissol and generates the executable. 

  * `test`: Runs unit test on the build.
  
  * `download`: Downloads the files required in the [tutorial](https://seissol.readthedocs.io/en/latest/a-first-example.html#a-first-example) and saves them in `/input-data`.
  
  * `execute`: Runs SeisSol using `mpiexec` with the input files from `/input-data` directory.
