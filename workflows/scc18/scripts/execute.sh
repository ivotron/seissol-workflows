#!/usr/bin/env bash
mkdir -p ./workflows/scc18/input-data/output
cp seissol/build/SeisSol_release_generatedKernels_dnoarch_hybrid_none_9_6 ./workflows/scc18/input-data
cd ./workflows/scc18/input-data
mpiexec --allow-run-as-root --oversubscribe -np 2 ./SeisSol_release_generatedKernels_dnoarch_hybrid_none_9_6 parameters.par > output/out.txt
