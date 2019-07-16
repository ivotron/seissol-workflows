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

REPO_DIR="$PWD/"
BASE_PATH="$REPO_DIR/workflows/scc18-containerless"
EXECUTION_DIR="$BASE_PATH/execution"

source "$BASE_PATH/scripts/setup-env.sh"

SEISSOL_BIN="$(ls $REPO_DIR/$SEISSOL_SRC_DIR/build/SeisSol_*)"
cp "$SEISSOL_BIN" "$EXECUTION_DIR"

mkdir -p "$EXECUTION_DIR/output"

# run
cd "$EXECUTION_DIR"

sed -i "s#EndTime = .*#EndTime = $SEISSOL_END_TIME#" parameters_zenodo_easi.par

echo "$REPO_DIR/$SEISSOL_SRC_DIR/Maple/" > DGPATH

mpirun \
  --oversubscribe \
  -np "$MPI_NUM_PROCESSES" \
  "$SEISSOL_BIN" \
  parameters_zenodo_easi.par > output/stdout.txt
