workflow "containers" {
  on = "push"
  resolves = "build and test"
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
