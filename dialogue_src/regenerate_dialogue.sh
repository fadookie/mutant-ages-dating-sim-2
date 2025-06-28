#!/bin/sh
# Script for Eliot's MacBook to regenerate dialogue from source
set -o errexit
cd "$(dirname "$0")"
/Users/eliot/dev/StrifeSpinner/StrifeSpinner/bin/Debug/net9.0/StrifeSpinner /Users/eliot/dev/mutant-ages-dating-sim-2/dialogue_src/yarn/emma.yarn /Users/eliot/dev/mutant-ages-dating-sim-2/dialogue_src/usdf/emma.template.usdf && node template-tool/template-tool.js
