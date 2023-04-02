#!/bin/bash

set -exo pipefail

TEST_VERSION="1.13.0"
BENCHMARK_VERSION="1.7.1"
BENCHMARK_BUILD_DIR=${BENCHMARK_BUILD_DIR:-/tmp}

cd "${BENCHMARK_BUILD_DIR}"
if [ ! -d benchmark ]; then
  HOME=/dev/null git clone https://github.com/google/benchmark.git
fi

cd benchmark
git checkout "v${BENCHMARK_VERSION}"


cd "${BENCHMARK_BUILD_DIR}/benchmark"
if [ ! -d googletest ]; then
  HOME=/dev/null git clone https://github.com/google/googletest.git
fi

cd googletest
git checkout "v${TEST_VERSION}"


function build_benchmark() {
  echo "Building google_benchmark build_type=${1}."

  cd "${BENCHMARK_BUILD_DIR}/benchmark"
  rm -rf build
  mkdir -p build
  cmake -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang \
   -DCMAKE_CXX_STANDARD=20 -DCMAKE_CXX_STANDARD_REQUIRED=ON \
   -DCMAKE_BUILD_TYPE="${1}"\
   -DBENCHMARK_ENABLE_GTEST_TESTS=ON -DBENCHMARK_DOWNLOAD_DEPENDENCIES=OFF -S . -B "build"
  cmake --build "build" --config ${1} --target install -- -j 20
}

function build_test() {
  echo "Building google_test target=${1}."

  cd "${BENCHMARK_BUILD_DIR}/benchmark/googletest"
  rm -rf build
  mkdir -p build
  cmake -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang \
   -DCMAKE_CXX_STANDARD=20 -DCMAKE_CXX_STANDARD_REQUIRED=ON \
   -DCMAKE_BUILD_TYPE="${1}"\
   -S . -B "build"
  cmake --build "build" --config ${1} --target install -- -j 20
}

build_benchmark Debug
build_test Debug
mv /usr/local/lib/libbenchmark.a /usr/local/lib/libbenchmark-debug.a
mv /usr/local/lib/libbenchmark_main.a /usr/local/lib/libbenchmark_main-debug.a
mv /usr/local/lib/libgmock.a /usr/local/lib/libgmock-debug.a
mv /usr/local/lib/libgmock_main.a /usr/local/lib/libgmock_main-debug.a
mv /usr/local/lib/libgtest.a /usr/local/lib/libgtest-debug.a
mv /usr/local/lib/libgtest_main.a /usr/local/lib/libgtest_main-debug.a

build_benchmark Release
build_test Release
mv /usr/local/lib/libbenchmark.a /usr/local/lib/libbenchmark-release.a
mv /usr/local/lib/libbenchmark_main.a /usr/local/lib/libbenchmark_main-release.a
mv /usr/local/lib/libgmock.a /usr/local/lib/libgmock-release.a
mv /usr/local/lib/libgmock_main.a /usr/local/lib/libgmock_main-release.a
mv /usr/local/lib/libgtest.a /usr/local/lib/libgtest-release.a
mv /usr/local/lib/libgtest_main.a /usr/local/lib/libgtest_main-release.a
