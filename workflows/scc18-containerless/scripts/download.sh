#!/usr/bin/env bash
set -e

file_list=""
for file in $(curl -H "Accept: application/json" -H "Content-Type: application/json" -X GET https://zenodo.org/api/records/439946 | jq -r '.files |.[]| .filename'); do
    file_list=$file_list$file,
done
export ZENODO_FILES=${file_list}
echo ${ZENODO_FILES}
IFS=','

mkdir -p workflows/scc18/execution/
cd workflows/scc18/execution/
for i in $ZENODO_FILES; do
  echo "$i"
  if [[ ! -e "$i" ]]; then
    curl -LO https://zenodo.org/record/439946/files/"$i"
  fi
done