#!/usr/bin/env bash
set -e
BASE_PATH="workflows/tpv33"


mkdir -p ${BASE_PATH}/input-data
pushd ${BASE_PATH}/input-data

curl -o tpv33_gmsh.xdmf https://syncandshare.lrz.de/dl/fiEi52Xiwwqkf2sNpTrCHjhw/tpv33_gmsh.xdmf
curl -o Examples.tar.gz "https://codeload.github.com/SeisSol/Examples/tar.gz/master"
curl -o tpv33_gmsh https://syncandshare.lrz.de/dl/fi72mQiszp6vSs7qN8tdZJf9/tpv33_gmsh

tar -xzf Examples.tar.gz
cp Examples-master/tpv33/* .
rm -rf Examples-master Examples.tar.gz
echo $PWD/Maple/ > DGPATH
popd

cp seissol/build/SeisSol_release_generatedKernels_dnoarch_hybrid_none_9_6 ${BASE_PATH}/input-data