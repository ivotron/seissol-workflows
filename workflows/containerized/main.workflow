workflow "containers" {
  on = "push"
  resolves = "execute"
}

action "build and test" {
  uses = "./workflows/containerized/actions/seissol"
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

action "download files"{
  needs = "build and test"
  uses = "actions/bin/curl@master"
  runs = ["sh", "-c", "workflows/containerized/scripts/download.sh"]
}

action "execute"{
  needs = "download files"
  uses = "./workflows/containerized/actions/seissol"
  runs = ["sh", "-c","workflows/containerized/scripts/execute.sh"]
}