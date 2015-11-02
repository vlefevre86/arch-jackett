#!/bin/bash

# define pacman packages
pacman_packages="git nuget"

# install required pre-reqs for makepkg
pacman -S --needed $pacman_packages --noconfirm

#grab the source
#/usr/bin/git clone https://github.com/zone117x/Jackett.git /opt/Jackett
#/usr/bin/git clone https://github.com/sdesbure/Jackett.git /opt/Jackett
/usr/bin/git clone https://github.com/Jackett/Jackett.git /opt/Jackett

#create jackett user
useradd -m -s /bin/bash jackett -d /opt/Jackett

cd /opt/Jackett

# get the last tag of Jackett
#LAST_TAG=`/usr/bin/git tag | /usr/bin/tail -1`

# Checkout this tag
#/usr/bin/git checkout $LAST_TAG

# install dependencies
for i in `find /opt/Jackett/ -name packages.config` ; do /usr/bin/nuget install $i -OutputDirectory /opt/Jackett/src/packages; done
#/usr/bin/nuget install /opt/Jackett/src/Jackett/packages.config -OutputDirectory /opt/Jackett/src/packages/

# make the build compilable by mono
for i in `find /opt/Jackett/ -name '*.csproj'`; do  sed -i -e 's/TargetFrameworkVersion>v4.5.[12]/TargetFrameworkVersion>v4.5/' -e 's/ToolsVersion=\"14.0\"/ToolsVersion=\"4.0\"/' $i ; done

# delete tray project which messes compilation
sed -i -e '/Jackett.Tray/,+1d' /opt/Jackett/src/Jackett.sln

# build
/usr/bin/xbuild /opt/Jackett/src/Jackett.sln /p:Configuration=Release

# "install"
/usr/bin/cp -r /opt/Jackett/src/Jackett.Console/bin/Release/* /opt/Jackett/

# put everything as jackett user
chown -R jackett:jackett /opt/Jackett/

# remove base devel tools and packer
pacman -Ru $pacman_packages --noconfirm

