#!/usr/bin/env bash
set -e

file_list=""
files=$(curl -H "Accept: application/json" \
        -H "Content-Type: application/json" \
        -X GET https://zenodo.org/api/records/439946 | \
        jq -r '.files |.[]| .filename'
        );
for file in $files; do
    file_list=$file_list$file,
done
IFS=','
mkdir -p workflows/scc18-containerless/execution/
cd workflows/scc18-containerless/execution/
for i in ${file_list}; do
  echo "$i"
  if [[ ! -e "$i" ]]; then
    curl -LO https://zenodo.org/record/439946/files/"$i"
  fi
done