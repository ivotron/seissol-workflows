workflow "containers" {
  on = "push"
  resolves = "execute"
}

action "build" {
  uses = "./actions/seissol"
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
   "-j8",
  ]
}

action "test" {
  needs = "build"
  uses = "./actions/seissol"
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
   "-j8",
   "check"
  ]
}

action "download"{
  needs = "test"
  uses = "./actions/seissol"
  runs = ["sh", "-c", "workflows/tpv33/scripts/download.sh"]
}

action "execute"{
  needs = "download"
  uses = "./actions/seissol"
  runs = ["sh", "-c","workflows/tpv33/scripts/execute.sh"]
}
