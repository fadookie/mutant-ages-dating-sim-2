#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
set -o xtrace
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
ACC_PATH=$(command -v acc)
ACC_DIRNAME=$(dirname "$ACC_PATH")
cd "$SCRIPT_PATH"
acc -i "$ACC_DIRNAME" src/acs_src/GLOBAL_ACS_STUFF.acs src/acs/GLOBAL_ACS_STUFF.o
