#!/bin/bash
gitfolder=$(find -type f -name PKGBUILD | sed 's/PKGBUILD//')
cd $gitfolder
file=$(find -type f -iname "*.zst" | cut -d "/" -f2)
for i in *.zst *.sig; do test -e $i && md5sum $i >> "$file"".md5"; done
exit 0
