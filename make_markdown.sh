#!/bin/sh
set -o errexit
set -o xtrace
pandoc --from gfm --to html --standalone README.md > README.html
pandoc --from gfm --to html --standalone CREDITS.md > CREDITS.html
