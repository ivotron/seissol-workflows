#!/usr/bin/env bash
source "$PWD/workflows/scc18-containerless/scripts/setup-env.sh"
if [ -z "$SEISSOL_SRC_DIR" ]; then
  echo "Expecting SEISSOL_SRC_DIR variable"
  exit 1
fi
cd $SEISSOL_SRC_DIR
git checkout master
scons compiler=gcc netcdf=yes hdf5=yes order=4 parallelization=hybrid -j8
