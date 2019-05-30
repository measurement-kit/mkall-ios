#!/bin/bash
set -ex
homebrew_basedir="/usr/local/opt"
./script/configure/update-frameworks $homebrew_basedir
./script/configure/update-resources $homebrew_basedir
