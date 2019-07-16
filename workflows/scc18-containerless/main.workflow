workflow "scc18" {
  resolves = "execute"
}

action "remove previous builds" {
  uses = "sh"
  args = ["rm -f submodules/seissol/build/SeisSol_*"]
}

action "install dependencies" {
  needs = "remove previous builds"
  uses = "sh"
  args = "workflows/scc18-containerless/scripts/install-deps.sh"
}

action "build" {
  needs = "install dependencies"
  uses = "sh"
  args = "workflows/scc18-containerless/scripts/compile.sh"
  env = {
    SEISSOL_SRC_DIR = "submodules/seissol"
  }
}

action "download data and parameters"{
  needs = "build"
  uses = "sh"
  args = "workflows/scc18-containerless/scripts/download-input.sh"
}

action "execute" {
  needs = "download data and parameters"
  uses = "sh"
  args = "workflows/scc18-containerless/scripts/run.sh"
  env = {
    SEISSOL_SRC_DIR = "submodules/seissol",
    OMP_NUM_THREADS = "1",
    MPI_NUM_PROCESSES = "20",
    SEISSOL_END_TIME = "0.00001"
  }
}
