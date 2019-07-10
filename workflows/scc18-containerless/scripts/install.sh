#!/usr/bin/env bash
set -e

mkdir -p install

# update .bashrc
cat >> $HOME/.bashrc_ <<EOL
export PATH=$HOME/bin:$PATH
export LIBRARY_PATH=$HOME/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$HOME/lib/pkgconfig:$PKG_CONFIG_PATH
export EDITOR=vi
export CPATH=$HOME/include:$CPATH
EOL
source ~/.bashrc
cd install
# installing scons

wget http://prdownloads.sourceforge.net/scons/scons-3.0.5.tar.gz
tar -xaf scons-3.0.5.tar.gz
cd scons-3.0.5
python setup.py install --prefix=$PWD/install
cd ..


# installing hdf5

wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.21/src/hdf5-1.8.21.tar.bz2
tar -xaf hdf5-1.8.21.tar.bz2
cd hdf5-1.8.21
CC=mpicc FC=mpif90 ./configure --enable-parallel --prefix=$PWD/install --with-zlib --disable-shared --enable-fortran
make -j8
make install
cd ..


# installing netcdf

wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.6.1.tar.gz
tar -xaf netcdf-4.6.1.tar.gz
cd netcdf-4.6.1
CC=h5pcc ./configure --enable-shared=no --disable-dap --prefix=$PWD/install
make -j8
make install
cd ..

# instaling libxsmm

git clone https://github.com/hfp/libxsmm
cd libxsmm
make generator
cp bin/libxsmm_gemm_generator $HOME/bin
cd ..

# installing pspamm

git clone https://github.com/peterwauligmann/PSpaMM.git
ln -s $(pwd)/PSpaMM/pspamm.py $HOME/bin