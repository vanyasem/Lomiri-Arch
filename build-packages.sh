#!/usr/bin/env bash
set -e

cmd_usage() {
  cat <<-_EOF
Options:
  help|-h      -  Print usage information
  build|-b     -  Build and install all packages
  rebuild|-r   -  Rebuild all packages
  needed|-n    -  Build packages that are not built
  missing|-m)  -  Build and install packages that are not yet installed
  clean|-c     -  Clean all packages
  uninstall|-u -  Uninstall all packages
  srcinfo|-s   -  Regenerate .SRCINFOs of all packages
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

cmd_missing() {
 sudo test true
 PACKAGES=$(cat projects.list.minimal)
 pacman -Q | awk '{print $1}' > packages_on_system.txt
 readarray -t package_on_system_list < packages_on_system.txt
 

   for package in $PACKAGES
   do
   
   result="$(value_in_array "${package}")"
   
    if [ "false" = "${result}" ]
   then
     cd "${package}"
     echo "#####  ${package}  #####"
     yes | makepkg -si
     echo "----------------------"
     cd ..
     fi
   done
 
}

value_in_array() {
  readarray -t package_on_system_list < packages_on_system.txt
  [[ " ${package_on_system_list[@]} " =~ " ${1} " ]] && echo "true" || echo "false"
}

cmd_clean() {
  for package in ./*/
  do
    cd ${package}
    makepkg -dCo
    cd ..
  done
}

cmd_uninstall() {
  sudo test true
  PACKAGES=$(cat projects.list)
  for package in $PACKAGES
  do
    yes | sudo pacman -Rdd ${package} || true
    echo "----------------------"
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
  help|-h)      shift; cmd_usage "$@" ;;
  build|-b)     shift; cmd_build "$@" ;;
  rebuild|-r)   shift; cmd_rebuild "$@" ;;
  needed|-n)    shift; cmd_needed "$@" ;;
  missing|-m)    shift; cmd_missing "$@" ;;
  clean|-c)     shift; cmd_clean "$@" ;;
  uninstall|-u) shift; cmd_uninstall "$@" ;;
  srcinfo|-s)   shift; cmd_srcinfo "$@" ;;
  *)                   cmd_usage "$@" ;;
esac
