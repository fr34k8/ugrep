#!/bin/bash

# help wanted?
case $1 in
  --help|-h)
    ./configure --help
    exit 0
    ;;
esac

echo
echo "Building ugrep..."

# fix git clone timestamp issues causing build failures
touch config.h.in lib/Makefile.in src/Makefile.in

# configure with colors enabled by default or the command arguments
OPTIONS=${1:---enable-color}

echo
echo "./configure $OPTIONS"
echo

./configure $OPTIONS

echo
echo "make -j clean all"
echo

make clean

if ! make -j ; then
  echo "Failed to build ugrep, please open an issue at:"
  echo "https://github.com/Genivia/ugrep/issues"
  exit 1
fi

echo
echo "make test"
echo

if ! make test ; then
  echo "Testing failed, please open an issue at:"
  echo "https://github.com/Genivia/ugrep/issues"
  exit 1
fi

echo
echo "OK"
