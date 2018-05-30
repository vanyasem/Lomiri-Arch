#!/usr/bin/env bash
sudo test
set -e

cmd_usage() {
  cat <<-_EOF
Options:
  help|-h  -  Print usage information
  rebuild|-r  -  Rebuild all packages
  needed|-n  -  Build packages that are not built
  clean|-c  -  Clean all packages
  srcinfo|-s  -  Regenerate .SRCINFO
_EOF
  exit 0
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
    if ! ls ./*.pkg.tar.xz 1> /dev/null 2>&1; then
      yes | makepkg -sr
      echo "----------------------"
    else
      echo ${package} already built
    fi
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
  rebuild|-r) shift; cmd_rebuild "$@" ;;
  needed|-n)  shift; cmd_needed "$@" ;;
  clean|-c)   shift; cmd_clean "$@" ;;
  srcinfo|-s) shift; cmd_srcinfo "$@" ;;
  *)                 cmd_usage "$@" ;;
esac
