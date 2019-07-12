#!/usr/bin/env bash
source $PWD/workflows/scc18-containerless/scripts/setup-env.sh
cd $SEISSOL_SRC_DIR
scons compiler=gcc netcdf=yes hdf5=yes order=4 parallelization=hybrid