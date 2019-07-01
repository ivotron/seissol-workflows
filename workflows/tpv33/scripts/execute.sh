#!/usr/bin/env bash

cd seissol/launch_SeisSol
OMP_NUM_THREADS=1 mpiexec --allow-run-as-root --oversubscribe -np 1 ./SeisSol_release_generatedKernels_dnoarch_hybrid_none_9_6 parameters_tpv33_master.par