workflow "containers" {
  on = "push"
  resolves = "build"
}

action "build" {
  uses = "popperized/scons@master"
  env = {
    SCONS_PROJECT_DIR = "seissol/"
    SCONS_INSTALL_DEPS_SCRIPT = "install_deps.sh",
  }
}
