workflow "scc18-containerless" {
  resolves = "execute"
}

action "remove previous builds" {
  uses = "sh"
  args = ["rm -rf submodules/seissol/build/ submodules/seissol/.scon*"]
}

action "checkout master branch" {
  needs = "remove previous builds"
  uses = "sh"
  args = "git -C submodules/seissol checkout master"
}

action "install dependencies" {
  needs = "checkout master branch"
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

action "download input data"{
  needs = "build"
  uses = "sh"
  args = "workflows/scc18-containerless/scripts/download-input.sh"
}

# MPI_NUM_PROCESSES needs to be a multiple of 20
action "execute" {
  needs = "download input data"
  uses = "sh"
  args = "workflows/scc18-containerless/scripts/run.sh"
  env = {
    SEISSOL_SRC_DIR = "submodules/seissol",
    OMP_NUM_THREADS = "1",
    MPI_NUM_PROCESSES = "20",
    SEISSOL_END_TIME = "0.00001"
  }
}
