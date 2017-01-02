#!/bin/bash

echo "reset local dbs..."
git reset --hard
git clean -f

# make sure all submodules are initialized and updated.
./init_update.sh
git submodule foreach ./reset.sh
