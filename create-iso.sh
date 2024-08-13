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

update_lxc_process_count() {
   LXC_PROCESS_COUNT=`lxc info kde-neon-core-iso-builder|grep Processes|awk '{print $2}'`
}

lxc init --vm ubuntu:24.04 $LXC_INSTANCE \
   -c limits.cpu=4 \
   -c limits.memory=8GiB \
   -d root,size=32GiB
lxc start $LXC_INSTANCE

# Wait for the VM to finish booting
set +x
echo "Waiting for VM boot to end"
update_lxc_process_count
while [ "$LXC_PROCESS_COUNT" -lt 0 ] ; do
   sleep 5
   update_lxc_process_count
done
echo "VM ready, process count: $LXC_PROCESS_COUNT"
set -x

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


