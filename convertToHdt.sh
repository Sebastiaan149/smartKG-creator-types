#!/usr/bin/env bash

OUTPUT_DIR="$1"
mkdir -p "$OUTPUT_DIR"

for file in *.nt; do
    ../../smartKG-creator-types/libhdt/tools/rdf2hdt "$file" "$OUTPUT_DIR/${file%.nt}.hdt"
done