#!/bin/sh
set -e

apt-get -y update
apt-get -y install --no-install-recommends bc

echo "Step 1 - ubuntu version is "$UBUNTU_VERSION

if [ `echo "$UBUNTU_VERSION>16.04"|bc` -eq 1 ]; then
    apt-get -y install --no-install-recommends gnupg2
else
    apt-key update
fi

if [ `echo "$UBUNTU_VERSION>18.04"|bc` -eq 1 ]; then
    apt-get -y install --no-install-recommends apt-utils locales
else
    apt-get -y install --no-install-recommends libapt-inst2.0 apt-utils locales
fi
