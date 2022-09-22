#!/bin/bash
git clone -b "master" "https://github.com/BigWigsMods/packager.git"
mv packager/release.sh .
rm -rf packager
chown +x release.sh
./release.sh -g wrath