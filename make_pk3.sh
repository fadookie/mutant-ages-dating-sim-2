#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

GIT_BUILD_NAME=$(echo -n `date "+%Y%m%d_%H%M"`_`git rev-parse --short HEAD`)
ARCHIVE_NAME="mutant-ages-dating-sim-2.pk3"
#ARCHIVE_NAME="raw/builds/mutant-ages-dating-sim-2_${GIT_BUILD_NAME}.pk3"

set -o xtrace
# Set flag --worktree-attributes to use .gitattributes from working directory instead of HEAD commit
git archive --format=zip -o "$ARCHIVE_NAME" HEAD:src

# Comment out to not display archive contents
# unzip -l "$ARCHIVE_NAME" | less
