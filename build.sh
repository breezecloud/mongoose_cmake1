#!/bin/sh
#copyright
#mail
#https://github.com/breezecloud/mongoose_cmake1

#exit on error
set -e

#exit on undefined variable
set -u

#print out commands if DEBUG is set
[ -z "${DEBUG+x}" ] || set -x

#get action
if [ -z "${1+x}" ]
then
  ACTION=""
else
  ACTION="$1"
fi

#colorful warnings and errors
echo_error() {
  printf "\e[0;31mERROR: "
  #shellcheck disable=SC2068
  echo $@
  printf "\e[m"
}

echo_warn() {
  printf "\e[1;33mWARN: "
  #shellcheck disable=SC2068
  echo $@
  printf "\e[m"
}

#save script path and change to it
STARTPATH=$(dirname "$(realpath "$0")")
cd "$STARTPATH" || exit 1

#set umask
umask 0022

#get version
VERSION=$(grep "  VERSION" CMakeLists.txt | sed 's/  VERSION //')
COPYRIGHT="myapp ${VERSION} | (c) 2018-2024 breezecloud <breezecloud@github.com> | GPL-3.0-or-later | https://github.com/breezecloud/gongoose_cmake1"

installdeps() {
  echo "Platform: $(uname -m)"
  if [ -f /etc/debian_version ]
  then
    apt-get update
    apt-get install -y --no-install-recommends \
      gcc cmake 
  elif [ -f /etc/arch-release ]
  then
    #arch
    pacman -Sy gcc base-devel cmake 
  elif [ -f /etc/alpine-release ]
  then
    #alpine
    apk add cmake openssl-dev 
  elif [ -f /etc/SuSE-release ]
  then
    #suse
    zypper install gcc cmake  
  elif [ -f /etc/redhat-release ]
  then
    #fedora
    yum install gcc cmake 
  else
    echo_warn "Unsupported distribution detected."
    echo "You should manually install:"
    echo "  - gcc or clang"
    echo "  - cmake"
  fi
}

buildrelease() {
  BUILD_TYPE=$1
  echo "Compiling myapp v${VERSION}"
  cmake -B release \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
    .
  make -j4 -C release
}

installrelease() {
  echo "Installing myapp"
  cd release || exit 1
  [ -z "${DESTDIR+x}" ] && DESTDIR=""
  make install DESTDIR="$DESTDIR"
  echo "myapp installed"
}

uninstall() {
  #cmake does not provide an uninstall target, instead its manifest is of use at least for
  #the binaries
  if [ -f "$STARTPATH/release/install_manifest.txt" ]
  then
    xargs rm -f < "$STARTPATH/release/install_manifest.txt"
  fi
  [ -z "${DESTDIR+x}" ] && DESTDIR=""
  #CMAKE_INSTALL_PREFIX="/usr"
  rm -f "$DESTDIR/usr/bin/myapp"    
}

case "$ACTION" in
  installdeps)
    installdeps
  ;;
  release)
    buildrelease "Release"
  ;;  
  install)
    installrelease
  ;;
  uninstall)
    uninstall
  ;;  
  *)
    echo "Usage: $0 <option>"
    echo "Version: ${VERSION}"
    echo ""
    echo "Build options:"
    echo "  installdeps:      installs build and runtime dependencies"    
    echo "  release:          build release files in directory release (stripped)"   
    echo "  install:          installs release files from directory release"
    echo "                    following environment variables are respected"
    echo "                      - DESTDIR=\"\""
    echo "  uninstall:        removes myapp files, leaves configuration and "
    echo "                    state files in place"
    echo "                    following environment variables are respected"
    echo "                      - DESTDIR=\"\""               
    echo ""
    exit 1
  ;;
  esac

exit 0   