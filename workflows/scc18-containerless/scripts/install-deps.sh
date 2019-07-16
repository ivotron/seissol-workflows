#!/usr/bin/env bash
set -e

BASE_PATH="$PWD/workflows/scc18-containerless"

source "$BASE_PATH/scripts/setup-env.sh"

INSTALL_DIR="$BASE_PATH/install"

cd "$INSTALL_DIR"

# installing scons
if [[ ! -e "$INSTALL_DIR/bin/scons" ]]; then
    wget http://prdownloads.sourceforge.net/scons/scons-3.0.5.tar.gz
    tar -xaf scons-3.0.5.tar.gz
    cd scons-3.0.5
    python setup.py install --prefix=$INSTALL_DIR
    cd ..
fi

echo "*******************Scons Installed*******************"

# installing hdf5
if [[ ! -e "$INSTALL_DIR/bin/h5pcc" ]]; then
    if [[ ! -d "$INSTALL_DIR/hdf5-1.8.21" ]]; then
      wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.21/src/hdf5-1.8.21.tar.bz2
      tar -xaf hdf5-1.8.21.tar.bz2
    fi
    cd hdf5-1.8.21
    CC=mpicc FC=mpif90 ./configure --enable-parallel --prefix=$INSTALL_DIR --with-zlib --disable-shared --enable-fortran
    make -j8
    make install
    cd ..
fi

echo "*******************HDF5 Installed*******************"

# installing netcdf
if [[ ! -e "$INSTALL_DIR/include/netcdf.h" ]]; then
    if [[ ! -d "$INSTALL_DIR/netcdf-4.6.1" ]]; then
        wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.6.1.tar.gz
        tar -xaf netcdf-4.6.1.tar.gz
    fi
    cd netcdf-4.6.1
    CC=h5pcc ./configure --enable-shared=no --disable-dap --prefix=$INSTALL_DIR
    make -j8
    make install
    cd ..
fi

echo "*******************NetCDF Installed*******************"

# instaling libxsmm
if [[ ! -e "$INSTALL_DIR/bin/libxsmm_gemm_generator" ]]; then
    git clone https://github.com/hfp/libxsmm || true
    cd libxsmm
    make generator
    cp bin/libxsmm_gemm_generator $INSTALL_DIR/bin
    cd ..
fi

echo "*******************libxsmm Installed*******************"

# installing pspamm
if [[ ! -e "$INSTALL_DIR/bin/pspamm.py" ]]; then
    git clone https://github.com/peterwauligmann/PSpaMM.git
    ln -s $(pwd)/PSpaMM/pspamm.py $INSTALL_DIR/bin
fi
echo "*******************PSpaMM Installed*******************"