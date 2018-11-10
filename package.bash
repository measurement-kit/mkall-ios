#!/bin/sh
set -ex
git clean -dffx
xcodebuild
tarball=mkall-ios-`git describe --tags`.tar.gz
(cd build/Release-iphoneos/ && tar -czf ../../$tarball mkall.framework)
