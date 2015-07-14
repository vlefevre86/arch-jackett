#!/bin/bash

# exit script if return code != 0
set -e

#grab the source
git clone https://github.com/zone117x/Jackett.git /opt/Jackett

cd /opt/Jackett

# get the last tag of Jackett
LAST_TAG=`git tag|tail -1`

# Checkout this tag
git checkout $LAST_TAG

# install dependencies
nuget install /opt/Jackett/src/Jackett/packages.config -OutputDirectory /opt/Jackett/src/packages/

# build
xbuild /opt/Jackett/src/Jackett.sln

# "install"
cp -r /opt/Jackett/src/Jackett/bin/Debug/* /opt/Jackett/
