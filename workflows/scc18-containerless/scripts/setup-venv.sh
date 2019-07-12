#!/usr/bin/env bash
set -e

python -m virtualenv $PWD/venv
source $PWD/venv/bin/activate
pip install numpy==1.12.0