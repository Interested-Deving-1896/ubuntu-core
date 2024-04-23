#! /bin/sh

set -e

find_ovmf_bin() {
    for f in \
        "/usr/share/OVMF/OVMF_CODE.fd" \
        "/usr/share/ovmf/x64/OVMF_CODE.fd" \
        "/usr/share/qemu/ovmf-x86_64-code.bin" \
    ; do
        if [ -f "$f" ]; then
            echo $f
            return 0
        fi
    done
    echo "Didn't find any usable OVMF code file!" 1>&2;
    return 1
}

SCRIPT_PATH=`readlink -f $0`
SCRIPT_DIR=`dirname $SCRIPT_PATH`

IMAGE=$1
OVMF_BIN=`find_ovmf_bin`

echo "If you need to access local-snaps from the guest run: mount -t 9p host_share /mnt"
qemu-system-x86_64 -smp 2 -m 2048 -machine accel=kvm \
      -display gtk,gl=on \
      -net nic,model=virtio -net user,hostfwd=tcp::8022-:22 \
      -drive file=$OVMF_BIN,if=pflash,format=raw,unit=0,readonly=on \
      -drive file=$IMAGE,cache=none,format=raw,id=main,if=none \
      -device virtio-blk-pci,drive=main,bootindex=1 \
      -fsdev local,id=fsdev0,path=$SCRIPT_DIR/local-snaps,security_model=none \
      -device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=host_share \
      -audiodev pa,id=snd0 \
      -device ac97,audiodev=snd0

