#!/usr/bin/env bash
set -e

cmd_usage() {
  cat <<-_EOF
Options:
  help|-h     -  Print usage information
  build|-b    -  Build and install all packages
  rebuild|-r  -  Rebuild all packages
  needed|-n   -  Build packages that are not built
  clean|-c    -  Clean all packages
  srcinfo|-s  -  Regenerate .SRCINFOs of all packages
_EOF
  exit 0
}

cmd_build() {
  sudo test true
  PACKAGES=$(cat projects.list)
  for package in $PACKAGES
  do
    cd ${package}
    yes | makepkg -sfi
    echo "----------------------"
    cd ..
  done
}

cmd_rebuild() {
  for package in ./*/
  do
    cd ${package}
    yes | makepkg -sfr --holdver
    echo "----------------------"
    cd ..
  done
}

cmd_needed() {
  for package in ./*/
  do
    cd ${package}
    yes | makepkg -sr || true
    echo "----------------------"
    cd ..
  done
}

cmd_clean() {
  for package in ./*/
  do
    cd ${package}
    makepkg -dCo
    cd ..
  done
}

cmd_srcinfo() {
  for package in ./*/
  do
    cd ${package}
    makepkg --printsrcinfo > .SRCINFO
    cd ..
  done
}

case "$1" in
  help|-h)    shift; cmd_usage "$@" ;;
  build|-b)   shift; cmd_build "$@" ;;
  rebuild|-r) shift; cmd_rebuild "$@" ;;
  needed|-n)  shift; cmd_needed "$@" ;;
  clean|-c)   shift; cmd_clean "$@" ;;
  srcinfo|-s) shift; cmd_srcinfo "$@" ;;
  *)                 cmd_usage "$@" ;;
esac
