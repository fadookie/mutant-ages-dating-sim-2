#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source _build_common.sh

set -o xtrace
# TODO: Exclude freedoom2.wad
# Set flag --worktree-attributes to use .gitattributes from working directory instead of HEAD commit
git archive --format=zip -o "$PK3_ARCHIVE_INPUT_NAME" HEAD:src

# Copy pk3 archive to windows standalone folder
cp -v "$PK3_ARCHIVE_INPUT_NAME" "$WIN_STANDALONE_PARENT_PATH/$WIN_STANDALONE_RELATIVE_PATH"

# Comment out to not display archive contents
# unzip -l "$PK3_ARCHIVE_INPUT_NAME" | less
