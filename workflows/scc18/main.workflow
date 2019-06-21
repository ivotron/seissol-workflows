workflow "scc18" {
  on = "push"
  resolves = "execute"
}

action "remove previous builds" {
  uses = "actions/bin/sh@master"
  args = ["rm -f submodules/seissol/build/SeisSol_*"]
}

action "install dependencies" {
  needs = "remove previous builds"
  uses = "popperized/spack@master"
  args = [
    "netcdf-fortran",
    "^netcdf@4.4.5", "+parallel-netcdf",
    "^openmpi@4.0.1",
    "^hdf@1.10.5 +fortran",
    "^scons@3.0.5",
  ]
}

action "build" {
  needs = "remove previous builds"
  uses = "popperized/spack@master"
  runs = ["sh", "-c","workflows/scc18/scripts/install.sh"]
  env = {
    SEISSOL_SRC_DIR = "submodules/seissol"
  }
}

action "download data and parameters"{
  needs = "build"
  uses = "popperized/zenodo/download@master"
  env = {
    ZENODO_RECORD_ID = "439946"
    ZENODO_OUTPUT_PATH = "./workflows/scc18/execution"
  }
}

action "execute"{
  needs = "download data and parameters"
  uses = "popperized/spack@master"
  runs = ["sh", "-c","workflows/scc18/scripts/execute.sh"]
  env = {
    SEISSOL_SRC_DIR = "submodules/seissol"
    OMP_NUM_THREADS = 1
    MPI_NUM_PROCESSES = 1
    SEISSOL_END_TIME = 0.00001
  }
}
