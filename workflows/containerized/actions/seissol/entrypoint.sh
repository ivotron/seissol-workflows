#!/bin/bash
set -e

source /scons/bin/activate

if [ ! -d "seissol" ]; then
  echo "Expecting seissol/ folder"
  exit 1
fi

cd seissol/

scons "$@"
