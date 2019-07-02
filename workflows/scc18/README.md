# SCC18 Workflow

This example workflow runs SeisSol with the input from a [Zenodo record](https://zenodo.org/record/439946).


## Workflow

The workflow consists of four actions:
  
  * `build`: Compiles seissol and generates the executable. 

  * `test`: Runs unit test on the build.
  
  * `download`: Downloads the files from [Zenodo](https://zenodo.org/) using [Zenodo action](https://github.com/popperized/zenodo) and saves them in `/input-data`.
  
  * `execute`: Runs SeisSol using `mpiexec` with the input files from `/input-data` directory.
