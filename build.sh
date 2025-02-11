#!/bin/bash

# Check if app name is provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide the app name as an argument"
    echo "Usage: $0 <app_name>"
    exit 1
fi

APP_NAME="$1"

# Function to run a command and print a warning if it fails
run_command() {
    "$@"
    if [ $? -ne 0 ]; then
        echo "Warning: Command failed: $@"
    fi
}

# Run each command using the run_command function
run_command rm -rf "$APP_NAME"
run_command docker rm tmpbuild
run_command docker build -t qtcrossbuild .
run_command docker create --name tmpbuild qtcrossbuild
run_command docker cp "tmpbuild:/build/project/$APP_NAME" "./$APP_NAME"

echo "Build script completed for $APP_NAME."