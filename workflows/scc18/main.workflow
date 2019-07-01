workflow "scc 18" {
  resolves = "execute"
}

action "build" {
  uses = "./actions/seissol"
  args = [
   "compileMode=release",
   "order=6",
   "parallelization=hybrid",
   "netcdf=yes",
   "hdf5=yes",
   "commThread=yes",
   "compiler=gcc",
   "unitTests=fast",
   "-j8",
  ]
}
action "test" {
  needs = "build"
  uses = "./actions/seissol"
  args = [
   "compileMode=release",
   "order=6",
   "parallelization=hybrid",
   "netcdf=yes",
   "hdf5=yes",
   "commThread=yes",
   "compiler=gcc",
   "unitTests=fast",
   "-j8",
   "check"
  ]
}
action "download" {
  needs = "test"
  uses = "popperized/zenodo/download@master"
  env = {
    ZENODO_RECORD_ID = "439946"
    ZENODO_OUTPUT_PATH = "./workflows/scc18/input-data"
    ZENODO_FILES="parameters.par"
  }
}
action "execute" {
  needs = "download"
  uses = "./actions/seissol"
  runs = ["sh", "-c","workflows/scc18/execute.sh"]
}