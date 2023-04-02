#!/bin/bash

set -exo pipefail

./build_boost.sh & ./build_hdr_histogram.sh ./build_test.sh
wait
