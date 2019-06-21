#!/bin/bash
set -e

if [ -z "$SEISSOL_SRC_DIR" ]; then
  echo "Expecting SEISSOL_SRC_DIR variable"
  exit 1
fi
if [ -z "$SCONS_NUM_BUILD_JOBS" ]; then
  echo "Expecting SEISSOL_SRC_DIR variable"
  exit 1
fi

##################

# FIXME: find paths to all dependencies
scons=$(spack location -i scons@3.0.5)
hdf5_dir=$(spack location...)

cd "$SEISSOL_SRC_DIR"

# FIXME: add all required build options
$scons \
  hdf5=yes \
  hdf5Dir=$hdf5_dir \
  netcdf=yes \
  netcdfDir=...
  -j$SCONS_NUM_BUILD_JOBS
