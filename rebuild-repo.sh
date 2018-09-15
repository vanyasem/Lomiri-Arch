#!/usr/bin/env bash
# TODO add --clean option
set -e
sudo test true

cd ..

PACKAGES=$(cat projects.list)
for package in $PACKAGES; do
    guzuta omakase build ${package}
done
