#!/bin/bash

# exit script if return code != 0
set -e

#grab the source
/usr/bin/git clone https://github.com/zone117x/Jackett.git /opt/Jackett

cd /opt/Jackett

# get the last tag of Jackett
LAST_TAG=`/usr/bin/git tag | /usr/bin/tail -1`

# Checkout this tag
/usr/bin/git checkout $LAST_TAG

# install dependencies
/usr/bin/nuget install /opt/Jackett/src/Jackett/packages.config -OutputDirectory /opt/Jackett/src/packages/

# build
/usr/bin/xbuild /opt/Jackett/src/Jackett.sln

# "install"
/usr/bin/cp -r /opt/Jackett/src/Jackett/bin/Debug/* /opt/Jackett/
