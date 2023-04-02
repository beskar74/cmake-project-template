#!/bin/bash

set -exo pipefail

HDR_VERSION=0.11.6
HDR_INSTALL_DIR=${HDR_INSTALL_DIR:-/usr/local}
HDR_BUILD_DIR=${HDR_BUILD_DIR:-/tmp}

cd "${HDR_BUILD_DIR}"
if [ ! -d HdrHistogram_c ]; then
  HOME=/dev/null git clone https://github.com/HdrHistogram/HdrHistogram_c.git
fi

cd HdrHistogram_c 
git checkout "${HDR_VERSION}"

function build() {
  echo "building HdrHistogram target=${1}"

  rm -rf build
  mkdir -p build
  cd build
  CC=/usr/bin/clang CXX=/usr/bin/clang++ cmake -DCMAKE_BUILD_TYPE=${1} ../
  make -j 20
  make install
  cd ../
}

build Debug
mv /usr/local/lib/libhdr_histogram_static.a /usr/local/lib/libhdr_histogram-debug.a

build Release
mv /usr/local/lib/libhdr_histogram_static.a /usr/local/lib/libhdr_histogram-release.a
