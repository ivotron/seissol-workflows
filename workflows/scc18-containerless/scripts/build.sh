#!/usr/bin/env bash
cd $SEISSOL_SRC_DIR
scons compiler=gcc netcdf=yes hdf5=yes order=4 parallelization=hybrid