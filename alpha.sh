#!/usr/bin/env bash
#

# Prevent loop if pattern doesn't match any filenames:
shopt -s nullglob

for name in [a-z]*-*.pkg.tar.xz; do
# Remove everything from the name up to & including the first -
  alph=${name#-*}
#
# Remove the dash & everything afterwards:
  alph=${alph%%-*}
    [ ! -d "$alph" ] && mkdir "$alph"
    mv "$name" "$alph"
done
