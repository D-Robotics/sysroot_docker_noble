#!/bin/bash

set -e

if [ "$#" -eq 0 ]; then
    echo "No command specified. Defaulting to 'build'."
    COMMAND="build"
else
    COMMAND=$1
fi

case $COMMAND in
    clean)
        echo "Cleaning up..."
        python -m scikit_build_core clean
        rm -rf build/ dist/ *.egg-info/ __pycache__/ _skbuild/
        echo "Cleanup complete."
        ;;
    build)
        echo "Building extension..."
        python -m build --wheel
        python -m auditwheel repair dist/*.whl -w dist/wheelhouse\
        --exclude libbpu.so.2 \
        --exclude libhbmem.so.1 \
        --exclude libalog.so.1 \
        --exclude libhbrt4.so \
        --exclude libdnn.so \
        --exclude libhbucp.so \
        --exclude libhbtl.so \
        --exclude libhb_arm_rpc.so \
        --exclude libperfetto_sdk.so \
        --exclude libcjson.so.1 \
        --exclude libjsoncpp.so.1
        rm -rf dist/*.whl
        mv dist/wheelhouse/*.whl dist
        echo "Build complete."
        ;;
    install)
        echo "Installing package..."
        python -m pip install --no-build-isolation .
        echo "Installation complete."
        ;;
    *)
        echo "Invalid command: $COMMAND"
        echo "Usage: $0 <command>"
        echo "Commands: clean, build, install"
        exit 1
        ;;
esac
