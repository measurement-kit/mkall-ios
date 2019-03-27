#!/bin/bash
set -ex

git submodule update --init  # Just in case

# Download all MK libraries in a single archive
if [ ! -f Frameworks/.stamp ]; then (
  ./script/build/unix/make-ios-frameworks
  rm -rf MK_DIST  # cleanup
  touch Frameworks/.stamp
) fi

# Download generic assets (.mmdb files, ca-bundle.pem)
if [ ! -f mkall/resources/.stamp ]; then (
  set -ex
  version=20190327
  shasum=bbff2710b89fe22611e6dd48d401064d02bd0232da72dde29fc8c2131abd33b7
  repodload=https://github.com/measurement-kit/generic-assets/releases/download
  curl -fsSLO $repodload/$version/generic-assets-$version.tar.gz
  real_shasum=`shasum -a 256 generic-assets-$version.tar.gz | awk '{print $1}'`
  [ $real_shasum = $shasum ]
  (
    set -ex
    rm -f mkall/resources/*
    cd mkall/resources
    tar -xzf ../../generic-assets-$version.tar.gz
  )
  rm -f generic-assets-$version.tar.gz
  touch mkall/resources/.stamp
) fi
