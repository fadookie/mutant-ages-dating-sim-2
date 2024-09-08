#!/bin/sh

OUTFILE='zscript.txt'

cd src

rm "$OUTFILE"

write() {
    echo "$@" >> "$OUTFILE"
}

write 'version "4.1"'
write ''

# macOS version:
#find -s xmen_zscript -type f | while read index; do
#    write '#include "'$index'"'
#done

# linux version (unsorted):
find xmen_zscript -type f | while read index; do
    write '#include "'$index'"'
done

echo "Wrote updated index to $OUTFILE"

