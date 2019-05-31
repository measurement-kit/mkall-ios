#!/bin/sh
set -ex
version=`grep -A 1 CFBundleShortVersionString mkall/Info.plist | tail -n1 | tr -d '[a-z]<>/ \t'`
carthage build --no-skip-current
carthage archive
sha256sum=`shasum -a 256 mkall.framework.zip | awk '{print $1}'`
cat mkall.podspec |                                                            \
  sed -e "s/^  s.version =.*$/  s.version = $version/g"                        \
      -e "s/^    :sha256 => .*$/    :sha256 => \"$sha256sum\"/g"               \
        > mkall.podspec.new
mv mkall.podspec.new mkall.podspec
