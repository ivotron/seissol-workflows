workflow "containers" {
  on = "push"
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
   "-j1",
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
   "-j1",
   "check"
  ]
}
action "download files"{
  needs = "test"
  uses = "./actions/seissol"
  runs = ["sh", "-c", "workflows/tpv33/scripts/download.sh"]
}

action "execute"{
  needs = "download files"
  uses = "./actions/seissol"
  runs = ["sh", "-c","workflows/tpv33/scripts/execute.sh"]
}