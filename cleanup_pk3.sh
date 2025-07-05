#!/bin/sh
set -o errexit
set -o xtrace
find src -name '.DS_Store' -delete
find src/maps \( -name '.*.dbs' -o -name '*.backup*' -o -name '*autosave*' \) -delete
