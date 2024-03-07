#!/bin/bash

export MACHINE="r4b"
export IMAGE="mui-base-image"
export VERSION=$(date +"%d%m%y_%H%M")

for arg in "$@"; do
	name=${arg%%=*}
	value=${arg#*=}
	case $name in
	#"image") export IMAGE="${value}" ;;
	"machine") export MACHINE="${value}" ;;
	esac
	shift
done

case $MACHINE in
"r4b") IMAGE="mui-base-image" ;;
"r02w") IMAGE="mui-remote-image" ;;
esac

echo "Building"
echo "MACHINE: $MACHINE"
echo "IMAGE: $IMAGE"
echo "VERSION: $VERSION"
export IMAGE_DIR="build/tmp-glibc/deploy/images/${MACHINE}"

source layers/poky/oe-init-build-env
bitbake $IMAGE

echo "Deploying $IMAGE image"
cp ../${IMAGE_DIR}/${IMAGE}-${MACHINE}.wic.bz2 ../artifacts/
bzip2 -d -f ../artifacts/${IMAGE}-${MACHINE}.wic.bz2
mv ../artifacts/${IMAGE}-${MACHINE}.wic ../artifacts/${IMAGE}-${VERSION}.rpi-sdimg
