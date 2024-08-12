#!/bin/sh

set -ex

SCRIPT_PATH=`readlink -f $0`
SCRIPT_DIR=`dirname $SCRIPT_PATH`

if [ -f "$SCRIPT_DIR/$1" ]; then
  CORE_IMAGE=$1
else
   echo "Provide Ubuntu Core compressed img file as first parameter"
   exit 1
fi

LXC_INSTANCE=kde-neon-core-iso-builder
LXC_PROJECT_ROOT=/root/kde-neon-core

cleanup() {
   lxc delete -f $LXC_INSTANCE
}
trap cleanup EXIT

lxc_exec() {
   lxc exec $LXC_INSTANCE -- $*
}

lxc init --vm ubuntu:24.04 $LXC_INSTANCE \
   -c limits.cpu=4 \
   -c limits.memory=8GiB \
   -d root,size=32GiB
lxc start $LXC_INSTANCE

# Give a chance to the VM to finish booting
sleep 30

for i in "create-iso-impl.sh" "image" $1 ; do
   lxc file push -p -r $SCRIPT_DIR/$i $LXC_INSTANCE$LXC_PROJECT_ROOT
done

lxc_exec snap install --classic ubuntu-image
lxc_exec apt-get install -y \
   mtools \
   xorriso

lxc_exec $LXC_PROJECT_ROOT/create-iso-impl.sh $CORE_IMAGE

CORE_ISO_IMAGE="${CORE_IMAGE%.*.*}.iso"
lxc file pull $LXC_INSTANCE$LXC_PROJECT_ROOT/image2/$CORE_ISO_IMAGE $SCRIPT_DIR


