#!/bin/bash
set -e

python -m venv ./venv

source ./venv/bin/activate

pip install --no-cache-dir scons==3.0.5 numpy>=1.12.0 lxml
