#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "No command specified. Defaulting to 'build'."
    COMMAND="build"
else
    COMMAND=$1
fi

case $COMMAND in
    clean)
        echo "Cleaning up..."
        python setup.py clean --all
        rm -rf build/ dist/ *.egg-info/ __pycache__/
        rm -f pyhbipchal.cpython-310-aarch64-linux-gnu.so
        echo "Cleanup complete."
        ;;
    build)
        echo "Building extension..."
        python setup.py build_ext --inplace
        echo "Build complete."
        ;;
    install)
        echo "Installing package..."
        python setup.py install
        echo "Installation complete."
        ;;
    *)
        echo "Invalid command: $COMMAND"
        echo "Usage: $0 <command>"
        echo "Commands: clean, build, install"
        exit 1
        ;;
esac
