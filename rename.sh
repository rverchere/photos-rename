#!/bin/bash

# Check if ImageMagick is installed
identify --version >/dev/null 2>&1 || { echo "ImageMagick is not installed, exiting" >&2; exit 1; }

output='output'
outwidth='2560'

mkdir ${output}

for i in `find . -iname "*.jpg"`; do
    d=`identify -format %[exif:DateTimeOriginal] ${i} | cut -d' ' -f1 | sed "s/:/-/g"`
    h=`identify -format %[exif:DateTimeOriginal] ${i} | cut -d' ' -f2 | sed "s/:/-/g"`
    b=`basename ${i} | cut -d'_' -f2`
    echo "convert ${i} to ${output}/${d}_${h}_${b}"
    convert -resize ${outwidth} $i ${output}/${d}_${h}_${b}
done
