#!/usr/bin/env bash
set -e

if [ -z "$SEISSOL_SRC_DIR" ]; then
  echo "Expecting SEISSOL_SRC_DIR variable"
  exit 1
fi

mkdir -p "$GITHUB_WORKSPACE/workflows/tpv33/execution"

cd "$GITHUB_WORKSPACE/workflows/tpv33/execution"

curl -LO https://syncandshare.lrz.de/dl/fiEi52Xiwwqkf2sNpTrCHjhw/tpv33_gmsh.xdmf
curl -LO https://syncandshare.lrz.de/dl/fi72mQiszp6vSs7qN8tdZJf9/tpv33_gmsh
curl -LO https://github.com/SeisSol/Examples/archive/master.tar.gz

tar xzf master.tar.gz
cp Examples-master/tpv33/* .
rm -rf Examples-master master.tar.gz

echo "$GITHUB_WORKSPACE/$SEISSOL_SRC_DIR/Maple/" > DGPATH
