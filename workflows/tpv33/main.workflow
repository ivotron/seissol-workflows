workflow "containers" {
  on = "push"
  resolves = "execute"
}

action "build and test" {
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

action "download files"{
  needs = "build and test"
  uses = "./actions/seissol"
  runs = ["sh", "-c", "workflows/tpv33/scripts/download.sh"]
}

action "execute"{
  needs = "download files"
  uses = "./actions/seissol"
  runs = ["sh", "-c","workflows/tpv33/scripts/execute.sh"]
}