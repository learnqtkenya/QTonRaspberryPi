#!/bin/bash

run_command() {
    "$@"
    if [ $? -ne 0 ]; then
        echo "Warning: Command failed: $@"
    fi
}

run_command rm -rf App
run_command docker rm tmpbuild
run_command docker build -t qtcrossbuild . 
run_command docker create --name tmpbuild qtcrossbuild
run_command docker cp tmpbuild:/build/project/App ./App

echo "Build script completed."
