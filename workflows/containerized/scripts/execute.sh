#!/usr/bin/env bash

tar -xzf Examples.tar.gz

pushd seissol
mkdir -p launch_SeisSol
cp -R build/SeisSol_release_generatedKernels_dnoarch_hybrid_none_9_4 launch_SeisSol/
cp ../Examples-master/tpv33/* launch_SeisSol
echo $PWD/Maple/ > launch_SeisSol/DGPATH
popd

cd seissol/launch_SeisSol
OMP_NUM_THREADS=1 mpiexec --allow-run-as-root -np 1 ./SeisSol_release_generatedKernels_dnoarch_hybrid_none_9_4 parameters_tpv33_master.par