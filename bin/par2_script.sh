#!/bin/bash

if ! command -v par2 &>/dev/null; then
  echo "Error: par2 command not found"
  exit 1
fi

FORMATS="rar zip 7z"

# Command line argument checks
if [ $# -eq 0 ]; then
  echo "Usage: $0 <archive_dir> [output_dir]"
  echo "Supported formats: $FORMATS"
  exit 1
fi

archive_dir="$1"
output_dir="${2:-./par2}"

[[ "$archive_dir" != */ ]] && archive_dir="${archive_dir}/"

mkdir -p "$output_dir"

for ext in $FORMATS; do
  for f in "$archive_dir"*."$ext"; do
    [[ -e "$f" ]] || continue

    par2 c -r10 "$f"

    destination="$output_dir/$(basename "${f%.*}")"

    mkdir -p "$destination"

    for p in "$f"*.par2; do
      mv "$p" "$destination/"
    done
  done
done
