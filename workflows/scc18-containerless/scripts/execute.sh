#!/usr/bin/env bash
set -e

if [ -z "$SEISSOL_SRC_DIR" ]; then
  echo "Expecting SEISSOL_SRC_DIR variable"
  exit 1
fi
if [ -z "$OMP_NUM_THREADS" ]; then
  echo "No OMP_NUM_THREADS variable defined"
  exit 1
fi
if [ -z "$MPI_NUM_PROCESSES" ]; then
  echo "No MPI_NUM_ROCESSES variable defined"
  exit
fi
if [ -z "$SEISSOL_END_TIME" ]; then
  echo "No SEISSOL_END_TIME variable defined"
  exit 1
fi

EXECUTION_DIR="workflows/scc18-containerless/execution"

SEISSOL_BIN="$(ls $SEISSOL_SRC_DIR/build/SeisSol_*)"
SEISSOL_BIN_NAME=$(basename ${SEISSOL_BIN})
cp "$SEISSOL_BIN" "$EXECUTION_DIR"

mkdir -p "$EXECUTION_DIR/output"

# run
cd "$EXECUTION_DIR"

sed -i "s#EndTime = .*#EndTime = $SEISSOL_END_TIME#" parameters.par
mpirun \
  -np "$MPI_NUM_PROCESSES" \
  "./$SEISSOL_BIN_NAME" \
  parameters.par > output/out.txt
