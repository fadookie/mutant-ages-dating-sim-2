GIT_BUILD_NAME=$(echo -n `date "+%Y%m%d_%H%M"`_`git rev-parse --short HEAD`)
PK3_ARCHIVE_BASENAME="mutant-ages-dating-sim-2"
PK3_ARCHIVE_INPUT_NAME="$PK3_ARCHIVE_BASENAME.pk3"
ARCHIVE_BASENAME="mutant-ages-dating-sim-2_${GIT_BUILD_NAME}"
PK3_ARCHIVE_COPY_PATH="${SCRIPT_DIR}/raw/builds/${ARCHIVE_BASENAME}.pk3"
WIN_ARCHIVE_PATH="${SCRIPT_DIR}/raw/builds/${ARCHIVE_BASENAME}_windows_standalone.zip"
WIN_STANDALONE_PARENT_PATH="$HOME/Library/Containers/com.isaacmarovitz.Whisky/Bottles/97677CB0-64BD-410F-9730-91A19AB230B9/drive_c/users/crossover/Desktop" # This path is specific to MacBook Pro 2024
WIN_STANDALONE_RELATIVE_PATH="gzdoom-4-14-2-windows"
