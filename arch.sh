#!/usr/bin/env bash
#

# Prevent loop if pattern doesn't match any filenames:
shopt -s nullglob

for name in [a-z]*.pkg.tar.xz; do
#
# Remove everything from the name up to & including the last -
    num=${name##*-}
#
# Remove the dot & everything afterwards:
    num=${num%%.*}

    [ ! -d "pkg-$num" ] && mkdir "pkg-$num"

    mv "$name" "pkg-$num"
done
