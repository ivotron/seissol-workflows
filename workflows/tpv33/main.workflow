workflow "containers" {
  on = "push"
  resolves = "execute"
}

action "remove previous builds" {
  uses = "actions/bin/sh@master"
  args = ["rm -f submodules/seissol/build/SeisSol_*"]
}

action "build" {
  needs = "remove previous builds"
  uses = "./workflows/tpv33/actions/seissol"
  args = [
   "compileMode=release",
   "order=2",
   "parallelization=hybrid",
   "netcdf=yes",
   "hdf5=yes",
   "commThread=no",
   "compiler=gcc",
   "unitTests=fast",
   "metis=yes",
   "-j2",
  ]
  env = {
    SEISSOL_SRC_DIR = "submodules/seissol"
  }
}

action "download data and parameters"{
  needs = "test"
  uses = "./workflows/tpv33/actions/seissol"
  runs = ["sh", "-c", "workflows/tpv33/scripts/download.sh"]
  env = {
    SEISSOL_SRC_DIR = "submodules/seissol"
  }
}

action "execute"{
  needs = "download data and parameters"
  uses = "./workflows/tpv33/actions/seissol"
  runs = ["sh", "-c","workflows/tpv33/scripts/execute.sh"]
  env = {
    SEISSOL_SRC_DIR = "submodules/seissol"
    OMP_NUM_THREADS = 1
    MPI_NUM_PROCESSES = 1
    SEISSOL_END_TIME = 0.00001
  }
}
