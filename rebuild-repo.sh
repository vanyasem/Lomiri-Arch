#!/usr/bin/env bash
# TODO add --clean option
set -e
sudo test true

PACKAGES=$(cat projects.list)

cd ..

for package in $PACKAGES; do
    guzuta omakase build ${package}
done
