#!/bin/bash

echo Update...
git pull
echo Start installation routine...
mkdir -p build &&
cd build &&
if [ -z "$prefix" ]; then
    cmake .. $@
else
    cmake .. -DCMAKE_INSTALL_PREFIX=$prefix $@
fi

if [ $? != 0 ]; then
    cd ..
    rm -rf build
    exit
fi

make install &&
cd .. &&
rm -rf build &&
echo Installation successful.

