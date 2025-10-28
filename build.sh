#!/bin/sh


echo "Copying assets"
mkdir -p docs/assets
cp content/assets/* docs/assets/
echo "Assets copied"

emacs -Q --script build-site.el
