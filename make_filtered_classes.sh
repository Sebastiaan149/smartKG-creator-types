#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./make_filtered_classes.sh <input.nt> <min_percent> <max_percent> [output.txt]
#
# Example:
#   ./make_filtered_classes.sh dbpedia.nt 0.01 5
#
# Meaning:
#   Keep only classes whose rdf:type occurrence count is between
#   min_percent and max_percent of all rdf:type triples.

if [[ $# -lt 3 || $# -gt 4 ]]; then
  echo "Usage: $0 <input.nt> <min_percent> <max_percent> [output.txt]" >&2
  exit 1
fi

INPUT_NT="$1"
MIN_PERCENT="$2"
MAX_PERCENT="$3"
OUTPUT_FILE="${4:-classes_filtered.txt}"

if [[ ! -f "$INPUT_NT" ]]; then
  echo "Error: file '$INPUT_NT' does not exist." >&2
  exit 1
fi

# Basic numeric validation
if ! [[ "$MIN_PERCENT" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "Error: min_percent must be a non-negative number." >&2
  exit 1
fi

if ! [[ "$MAX_PERCENT" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "Error: max_percent must be a non-negative number." >&2
  exit 1
fi

awk -v minp="$MIN_PERCENT" -v maxp="$MAX_PERCENT" '
BEGIN {
  rdf_type = "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  total_type_triples = 0
}

# Only consider lines that look like regular N-Triples with rdf:type as predicate.
# Expected form:
#   <subject> <predicate> <object> .
#
# We only keep object IRIs (<...>) as classes.
$2 == rdf_type {
  class = $3

  # Only keep IRI objects, not literals or blank nodes
  if (class ~ /^<[^>]+>$/) {
    gsub(/^</, "", class)
    gsub(/>$/, "", class)
    counts[class]++
    total_type_triples++
  }
}

END {
  if (total_type_triples == 0) {
    print "Error: no rdf:type triples found in input." > "/dev/stderr"
    exit 1
  }

  min_count = (minp / 100.0) * total_type_triples
  max_count = (maxp / 100.0) * total_type_triples

  # Keep only classes within thresholds
  for (c in counts) {
    if (counts[c] >= min_count && counts[c] <= max_count) {
      print c
    }
  }
}
' "$INPUT_NT" | sort -u > "$OUTPUT_FILE"

echo "Wrote filtered classes to: $OUTPUT_FILE"

# Also print a short summary
TOTAL_CLASSES=$(wc -l < "$OUTPUT_FILE" | tr -d " ")
echo "Number of kept classes: $TOTAL_CLASSES"