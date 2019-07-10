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

EXECUTION_DIR="workflows/scc18/execution/"

SEISSOL_BIN="$(ls $SEISSOL_SRC_DIR/build/SeisSol_*)"

cp "$SEISSOL_BIN" "$EXECUTION_DIR"

mkdir -p "$EXECUTION_DIR/output"

sed -i "s#EndTime = .*#EndTime = $SEISSOL_END_TIME#" parameters.par

# run
cd "$EXECUTION_DIR"
mpirun \
  --allow-run-as-root \
  --oversubscribe \
  -np "$MPI_NUM_PROCESSES" \
  "$SEISSOL_BIN" \
  parameters.par > output/out.txt
