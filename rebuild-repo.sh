#!/usr/bin/env bash
# TODO add --clean option
set -e
sudo test

cd ..
guzuta omakase build lcov
guzuta omakase build gcovr
guzuta omakase build python-dbusmock
guzuta omakase build mir
guzuta omakase build mir-git
guzuta omakase build cmake-extras-git
guzuta omakase build libqtdbustest-git
guzuta omakase build unity-api-git
guzuta omakase build dbus-test-runner
guzuta omakase build libertine-git
