#!/bin/bash

IMAGE="core-image-base"
IMAGE_DIR="build/tmp/deploy/images/raspberrypi4"

. layers/poky/oe-init-build-env

bitbake $IMAGE
cp ../${IMAGE_DIR}/${IMAGE}-raspberrypi4.wic.bz2 ../artifacts/
bzip2 -d -f ../artifacts/${IMAGE}-raspberrypi4.wic.bz2
mv ../artifacts/${IMAGE}-raspberrypi4.wic ../artifacts/dev-image.rpi-sdimg
