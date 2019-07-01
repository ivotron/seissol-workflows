#!/usr/bin/env bash
set -e

mkdir -p workflows/tpv33/tpv33-files
curl -o workflows/tpv33/tpv33-files/tpv33_gmsh.xdmf https://syncandshare.lrz.de/dl/fiEi52Xiwwqkf2sNpTrCHjhw/tpv33_gmsh.xdmf
curl -o workflows/tpv33/tpv33-files/Examples.tar.gz "https://codeload.github.com/SeisSol/Examples/tar.gz/master"
curl -o workflows/tpv33/tpv33-files/tpv33_gmsh https://syncandshare.lrz.de/dl/fi72mQiszp6vSs7qN8tdZJf9/tpv33_gmsh

tar -xzf workflows/tpv33/tpv33-files/Examples.tar.gz -C workflows/tpv33/tpv33-files

mkdir -p seissol/launch_SeisSol
cp workflows/tpv33/tpv33-files/tpv33_gmsh* seissol/launch_SeisSol
cp seissol/build/SeisSol_release_generatedKernels_dnoarch_hybrid_none_9_6 seissol/launch_SeisSol/
cp workflows/tpv33/tpv33-files/Examples-master/tpv33/* seissol/launch_SeisSol
echo $PWD/Maple/ > seissol/launch_SeisSol/DGPATH