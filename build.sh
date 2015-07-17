#!/bin/bash

# exit script if return code != 0
set -e
# define pacman packages
pacman_packages="git nuget"

# install required pre-reqs for makepkg
pacman -S --needed $pacman_packages --noconfirm

#grab the source
/usr/bin/git clone https://github.com/zone117x/Jackett.git /opt/Jackett

#create jackett user
useradd -m -s /bin/bash jackett -d /opt/Jackett

cd /opt/Jackett

# get the last tag of Jackett
#LAST_TAG=`/usr/bin/git tag | /usr/bin/tail -1`

# Checkout this tag
#/usr/bin/git checkout $LAST_TAG

# install dependencies
/usr/bin/nuget install /opt/Jackett/src/Jackett/packages.config -OutputDirectory /opt/Jackett/src/packages/

# build
/usr/bin/xbuild /opt/Jackett/src/Jackett.sln

# "install"
/usr/bin/cp -r /opt/Jackett/src/Jackett/bin/Debug/* /opt/Jackett/

# put everything as jackett user
chown -R jackett:jackett /opt/Jackett/

# remove base devel tools and packer
pacman -Ru $pacman_packages --noconfirm

