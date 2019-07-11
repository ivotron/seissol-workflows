#!/usr/bin/env bash
set -e

mkdir -p $PWD/workflows/scc18-containerless/install

# update .bashrc

export PATH=$PWD/workflows/scc18-containerless/install/bin:$PATH
export LIBRARY_PATH=$PWD/workflows/scc18-containerless/install/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$PWD/workflows/scc18-containerless/install/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$PWD/workflows/scc18-containerless/install/lib/pkgconfig:$PKG_CONFIG_PATH
export CPATH=$PWD/workflows/scc18-containerless/install/include:$CPATH


cd $PWD/workflows/scc18-containerless/install
# installing scons

wget http://prdownloads.sourceforge.net/scons/scons-3.0.5.tar.gz
tar -xaf scons-3.0.5.tar.gz
cd scons-3.0.5
python setup.py install --prefix=$PWD/workflows/scc18-containerless/install
cd ..


# installing hdf5

wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.21/src/hdf5-1.8.21.tar.bz2
tar -xaf hdf5-1.8.21.tar.bz2
cd hdf5-1.8.21
CC=mpicc FC=mpif90 ./configure --enable-parallel --prefix=$PWD/workflows/scc18-containerless/install --with-zlib --disable-shared --enable-fortran
make -j8
make install
cd ..


# installing netcdf

wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.6.1.tar.gz
tar -xaf netcdf-4.6.1.tar.gz
cd netcdf-4.6.1
CC=h5pcc ./configure --enable-shared=no --disable-dap --prefix=$PWD/workflows/scc18-containerless/install
make -j8
make install
cd ..

# instaling libxsmm

git clone https://github.com/hfp/libxsmm
cd libxsmm
make generator
cp bin/libxsmm_gemm_generator $PWD/workflows/scc18-containerless/install/bin
cd ..

# installing pspamm

git clone https://github.com/peterwauligmann/PSpaMM.git
ln -s $(pwd)/PSpaMM/pspamm.py $PWD/workflows/scc18-containerless/install/bin