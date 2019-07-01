#!/bin/bash
#
# must be run as sudo; assumes the following is already installed:
#   - scons
#   - c/c++/fortran compiler
#   - cmake
#   - python and pip

# TODO: add support for other than debian-based distros

sed -i 's#\(deb http://deb.debian.org/debian .*main.*\)#\1 non-free#' /etc/apt/sources.list

apt update
apt install -y \
  libopenmpi-dev hdf5-tools libhdf5-mpi-dev \
  libnetcdf-mpi-dev libmetis-dev libparmetis-dev

# apt cleanup (when building docker images)
rm -rf /var/lib/apt/lists/*

pip install 'numpy>=1.12.0' lxml scons

# install libxssm
curl -LO https://github.com/hfp/libxsmm/archive/master.tar.gz
tar xvfz master.tar.gz
pushd libxsmm-master
make generator
cp bin/libxsmm_gemm_generator /usr/bin
popd
rm -rf libxsmm-master/
