#!/usr/bin/env bash
# This script is designed to duplicate frames of a
set -o errexit
set -o nounset
set -o pipefail

PREFIX="$1"
FRAMELETTER="$2"

echo "Using prefix '$PREFIX' and frame letter '$FRAMELETTER'"

SPRITEBASE="${PREFIX}${FRAMELETTER}"

# Copy front-facing frames
cp -v ${SPRITEBASE}{1,7${FRAMELETTER}3}.png
cp -v ${SPRITEBASE}{1,8${FRAMELETTER}2}.png

# Copy back-facing frame
cp -v ${SPRITEBASE}{5,6${FRAMELETTER}4}.png
