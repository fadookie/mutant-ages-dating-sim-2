#!/bin/sh
set -o errexit
set -o nounset
set -o pipefail

cd -- "$(dirname "$0")"
OUT_FILE='../src/dialogue.usdf'

cat usdf/* > "$OUT_FILE"
echo merged usdf/* to "$OUT_FILE"
