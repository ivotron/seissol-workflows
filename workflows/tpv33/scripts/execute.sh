#!/usr/bin/env bash

cd ./workflows/tpv33/input-data
mpiexec --allow-run-as-root --oversubscribe  -np 2 ./SeisSol_release_generatedKernels_dnoarch_hybrid_none_9_6 parameters_tpv33_master.par > output/out.txt