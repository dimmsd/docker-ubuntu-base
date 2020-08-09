#!/bin/sh
set -e

echo "Step 2 - ubuntu version is "$UBUNTU_VERSION

if [ `echo "$UBUNTU_VERSION<16.10"|bc` -eq 1 ]; then
    apt-key update
fi
