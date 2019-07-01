workflow "scc 18" {
  resolves = "download"
}

action "download" {
  uses = "popperized/zenodo/download@master"
  env = {
    ZENODO_RECORD_ID = "439946"
    ZENODO_OUTPUT_PATH = "./workflows/scc18/input-data"
    ZENODO_FILES="parameters.par"
  }
}