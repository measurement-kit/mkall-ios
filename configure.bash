#!/bin/bash
set -ex
prebuilt_repo=https://github.com/measurement-kit/prebuilt

# Download all MK libraries in a single archive
(
  set -ex
  version=0.9.0-alpha.11-9
  shasum=b9a4e2a09bc7eb8a7cfb8cc9404fe2c6951dac1721a13d67330a0a67db553c55
  curl -fsSLO $prebuilt_repo/releases/download/testing/ios-all-$version.tar.gz
  real_shasum=`shasum -a 256 ios-all-$version.tar.gz | awk '{print $1}'`
  [ $real_shasum = $shasum ]
  rm -rf Framework/*
  (
    set -ex
    cd Framework
    tar -xzf ../ios-all-$version.tar.gz
  )
  rm -f ios-all-$version.tar.gz
)

# Download generic assets (.mmdb files, ca-bundle.pem)
(
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
)
