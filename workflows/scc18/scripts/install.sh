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

##################

# FIXME: find paths to all dependencies
scons=$(spack location -i scons@3.0.5)/bin/scons
hdf5_dir=$(spack location -i hdf)
netcdf_dir=$(spack location -i netcdf+parallel-netcdf)
cd "$SEISSOL_SRC_DIR"

# FIXME: add all required build options
$scons \
  compileMode=release \
  order=2 \
  parallelization=hybrid \
  metis=yes \
  commThread=no \
  compiler=gcc \
  hdf5=yes \
  hdf5Dir=$hdf5_dir \
  netcdf=yes \
  netcdfDir=$netcdf_dir \
  -j$SCONS_NUM_BUILD_JOBS
