#!/usr/bin/env bash
set -e

cmd_usage() {
  cat <<-_EOF
Options:
  help|-h      -  Print usage information
  build|-b     -  Build and install all packages
  rebuild|-r   -  Rebuild all packages
  needed|-n    -  Build packages that are not built
  clean|-c     -  Clean all packages
  uninstall|-u -  Uninstall all packages
  srcinfo|-s   -  Regenerate .SRCINFOs of all packages
Environment Variables:
  PROJECT_LIST - select list to use
_EOF
  exit 0
}

PACKAGES=$(cat "${PROJECT_LIST:-projects.list}")

cmd_build() {
  sudo test true
  for package in $PACKAGES
  do
    cd ${package}
    makepkg -si --noconfirm
    echo "----------------------"
    cd ..
  done
}

cmd_rebuild() {
  sudo test true
  for package in $PACKAGES
  do
    cd ${package}
    makepkg -sfr --holdver --noconfirm
    echo "----------------------"
    cd ..
  done
}

cmd_needed() {
  sudo test true
  for package in $PACKAGES
  do
    cd ${package}
    makepkg -si --needed --noconfirm
    echo "----------------------"
    cd ..
  done
}

cmd_clean() {
  sudo test true
  for package in $PACKAGES
  do
    cd ${package}
    makepkg -dCo
    cd ..
  done
}

cmd_uninstall() {
  sudo test true
  for package in $PACKAGES
  do
    yes | sudo pacman -Rdd ${package} || true
    echo "----------------------"
  done
}

cmd_srcinfo() {
  for package in $PACKAGES
  do
    cd ${package}
    makepkg --printsrcinfo > .SRCINFO
    cd ..
  done
}

case "$1" in
  help|-h)      shift; cmd_usage "$@" ;;
  build|-b)     shift; cmd_build "$@" ;;
  rebuild|-r)   shift; cmd_rebuild "$@" ;;
  needed|-n)    shift; cmd_needed "$@" ;;
  clean|-c)     shift; cmd_clean "$@" ;;
  uninstall|-u) shift; cmd_uninstall "$@" ;;
  srcinfo|-s)   shift; cmd_srcinfo "$@" ;;
  *)                   cmd_usage "$@" ;;
esac
