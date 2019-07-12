#!/usr/bin/env bash
source  $PWD/workflows/scc18-containerless/scripts/setup-env.sh
venv_dir=$PWD/venv
cd $SEISSOL_SRC_DIR
git checkout master
source $venv_dir/bin/activate
scons compiler=gcc netcdf=yes hdf5=yes order=4 parallelization=hybrid