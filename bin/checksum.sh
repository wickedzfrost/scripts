#!/bin/bash

if ! command -v sha256sum &>/dev/null; then
  echo "Error: sha256sum command not found"
  exit 1
fi

if [ $# -eq 0 ]; then
  echo "Usage: $0 <checksum_dir>"
  exit 1
fi

checksum_dir="$1"
[[ "$checksum_dir" != */ ]] && checksum_dir="${checksum_dir}/"

sha256sum "$checksum_dir"*.7z >checksums.txt
