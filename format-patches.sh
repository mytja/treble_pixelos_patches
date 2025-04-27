#!/bin/bash

set -e

patches="$(readlink -f -- $1)"
tree="$2"
patch_start="m/fifteen...trebledroid"

for project in $(cd $patches/patches/$tree; echo *); do
    p="$(tr _ / <<<$project |sed -e 's;platform/;;g')"
    [ "$p" == build ] && p=build/make
    [ "$p" == treble/app ] && p=treble_app
    [ "$p" == vendor/hardware/overlay ] && p=vendor/hardware_overlay
    pushd $p &>/dev/null
    if [[ "$tree" == "personal" ]]; then
        patch_start="trebledroid"
        if [[ ! $(git tag -l "$patch_start") ]]; then
            patch_start="m/15.0"
        fi
        if [[ ! $(git tag -l "$patch_start") ]]; then
            patch_start="m/fifteen"
        fi
    fi
    git format-patch "$patch_start"
    rm $patches/patches/$tree/$project/*.patch || true
    mv *.patch $patches/patches/$tree/$project
    popd &>/dev/null
done
