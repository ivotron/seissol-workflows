#!/usr/bin/env bash
git clone https://github.com/SeisSol/SeisSol.git
cd SeisSol
git submodule update --init
scons compiler=gcc netcdf=yes hdf5=yes order=4 parallelization=hybrid