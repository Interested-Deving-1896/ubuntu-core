#! /bin/sh

IMAGE=$1

qemu-system-x86_64 -smp 2 -m 2048 -machine accel=kvm \
      -display gtk,gl=on \
      -net nic,model=virtio -net user,hostfwd=tcp::8022-:22 \
      -drive file=/usr/share/qemu/ovmf-x86_64.bin,if=pflash,format=raw,unit=0,readonly=on \
      -drive file=$IMAGE,cache=none,format=raw,id=main,if=none \
      -device virtio-blk-pci,drive=main,bootindex=1 \
      -audiodev pa,id=snd0 \
      -device ac97,audiodev=snd0

