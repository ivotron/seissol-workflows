#!/bin/bash
set -e

if [ -z "$SEISSOL_SRC_DIR" ]; then
  echo "Expecting SEISSOL_SRC_DIR variable"
  exit 1
fi
if [ -z "$SCONS_NUM_BUILD_JOBS" ]; then
  echo "Expecting SCONS_NUM_BUILD_JOBS variable"
  exit 1
fi

# paths for seissol
SPACK_VIEW="$PWD/spack/env/view/"
export PATH="$SPACK_VIEW/bin:$PATH"
export LIBRARY_PATH="$SPACK_VIEW/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="$SPACK_VIEW/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$SPACK_VIEW/lib/pkgconfig:$PKG_CONFIG_PATH"
export CPATH="$SPACK_VIEW/include:$CPATH"

# scons via virtualenv
source $PWD/venv/bin/activate

##################

cd "$SEISSOL_SRC_DIR"

scons \
  compileMode=release \
  order=2 \
  parallelization=hybrid \
  compiler=gcc \
  hdf5=yes \
  netcdf=yes \
  netcdfDir=$SPACK_VIEW \
  -j$SCONS_NUM_BUILD_JOBS
