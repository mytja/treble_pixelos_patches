#!/bin/bash
patches="$(readlink -f -- $1)"

./patches/apply-patches.sh $patches trebledroid
./patches/apply-patches.sh $patches personal

./patches/format-patches.sh $patches trebledroid
./patches/format-patches.sh $patches personal
