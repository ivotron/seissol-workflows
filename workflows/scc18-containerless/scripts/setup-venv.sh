#!/usr/bin/env bash
set -e

virtualenv venv -p python3
source $PWD/venv/bin/activate
pip install "numpy>=1.12.0"