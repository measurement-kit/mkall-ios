#!/bin/bash
set -ex
prebuilt_repo=https://github.com/measurement-kit/prebuilt

git submodule update --init  # Just in case

# Download all MK libraries in a single archive
if [ ! -f Frameworks/.stamp ]; then (
  ./script/build/unix/make-ios-frameworks
  rm -rf MK_DIST  # cleanup
  touch Frameworks/.stamp
) fi

# TODO(bassosimone): this should perhaps be a release of the assets themselves.
# Download generic assets (.mmdb files, ca-bundle.pem)
if [ ! -f mkall/resources/.stamp ]; then (
  set -ex
  version=20181028
  shasum=caffe9d811b87f6bb45a5011b58982844f5d3d126ba99339a31c0cbcda6b67b6
  curl -fsSLO $prebuilt_repo/releases/download/testing/generic-assets-$version.tar.gz
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
