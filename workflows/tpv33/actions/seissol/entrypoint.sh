#!/bin/bash
set -e

source /scons/bin/activate

if [ -z "$SEISSOL_SRC_DIR" ]; then
  echo "Expecting SEISSOL_SRC_DIR variable"
  exit 1
fi

cd $SEISSOL_SRC_DIR

scons "$@"
