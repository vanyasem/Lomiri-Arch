#!/usr/bin/env bash
# TODO add --clean option
set -e
sudo test true

PACKAGES=$(cat projects.list)
ARCH=x86_64 # TODO: Arch Selection

cd ..
arch-nspawn ./chroot-${ARCH}/root pacman -Syyu

for package in $PACKAGES; do
    guzuta omakase build ${package}
    arch-nspawn ./chroot-${ARCH}/root pacman -Syy
done
