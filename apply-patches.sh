#!/bin/bash

set -e

patches="$(readlink -f -- $1)"
tree="$2"

for project in $(cd $patches/patches/$tree; echo *); do
    p="$(tr _ / <<<$project |sed -e 's;platform/;;g')"
    [ "$p" == build ] && p=build/make
    [ "$p" == treble/app ] && p=treble_app
    [ "$p" == vendor/hardware/overlay ] && p=vendor/hardware_overlay
    echo "### APPLYING $p PATCHES"
    pushd $p &>/dev/null
    git tag -d "$tree" || true     # Silently delete a tag
    for patch in $patches/patches/$tree/$project/*.patch; do
        git am --reject $patch || read -p "--- Patch $patch needs manual application. Waiting for the patch to be applied."
    done
    git tag "$tree"
    popd &>/dev/null
done

