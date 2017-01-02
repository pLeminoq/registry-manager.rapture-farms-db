#!/bin/bash


upgrade(){
    echo "upgrade external dbs..."

    # make sure all submodules are initialized and updated.
    ./init_update.sh
    echo "==="
    git submodule foreach git status
    echo "==="
    echo "all changes commited?"
    waitConfirmation
    git submodule foreach git checkout master
    git submodule foreach git pull

    echo "==="
    git status
    echo "==="
    echo "should all changes be commited? This also includes top level db changes."
    waitConfirmation
    git commit -am "external db upgrade"
    git push
}

waitConfirmation(){
read -p "Please type y to confirm: " -n 1 -r &&
    echo &&  # new line
    if [[ ! $REPLY =~ ^[YyZz]$ ]]; then
        echo "Release aborted by user..."
        exit 255
    fi
}

upgrade
