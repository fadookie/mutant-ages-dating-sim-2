#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source _build_common.sh

set -o xtrace

# Build pk3 archive to $PK3_ARCHIVE_INPUT_NAME - uncomment to enable auto-builds
./make_pk3.sh

# Build docs
./make_markdown.sh

# Copy pk3 archive to builds folder
cp -v "$PK3_ARCHIVE_INPUT_NAME" "$PK3_ARCHIVE_COPY_PATH"

# Copy docs to builds folder
cp -v *.md *.html "$WIN_STANDALONE_PARENT_PATH/$WIN_STANDALONE_RELATIVE_PATH"

# cd to windows folder for gzdoom portable install
pushd "$WIN_STANDALONE_PARENT_PATH"
zip -r "$WIN_ARCHIVE_PATH" "$WIN_STANDALONE_RELATIVE_PATH"

# Comment out to not display archive contents
# unzip -l "$WIN_ARCHIVE_PATH" | less
