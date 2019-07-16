#!/usr/bin/env bash

BASE_PATH="$PWD/workflows/scc18-containerless"

mkdir -p "$BASE_PATH/install"

export PATH="$BASE_PATH/install/bin:$PATH"
export LIBRARY_PATH="$BASE_PATH/install/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="$BASE_PATH/install/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$BASE_PATH/install/lib/pkgconfig:$PKG_CONFIG_PATH"
export CPATH="$BASE_PATH/install/include:$CPATH"

if [[ ! -d "$BASE_PATH/venv" ]]; then
    virtualenv -p python3 "$BASE_PATH/venv"
fi

source "$BASE_PATH/venv/bin/activate"
pip install "numpy>=1.12.0"
