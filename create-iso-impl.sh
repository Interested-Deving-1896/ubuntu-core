#!/bin/sh

set -ex

SCRIPT_PATH=`readlink -f $0`
SCRIPT_DIR=`dirname $SCRIPT_PATH`

cd $SCRIPT_DIR

if [ -f "$1" ]; then
  CORE_IMAGE=$1
else
   echo "Provide Ubuntu Core compressed img file as first parameter"
   exit 1
fi

IMAGE_SIZE=`stat -c%s $CORE_IMAGE`

cat image/install-sources.yaml.in |sed "s,@SIZE@,$IMAGE_SIZE,g" > image/install-sources.yaml
cat image/core-desktop.yaml.in |sed "s,@PATH@,$CORE_IMAGE,g" > image/core-desktop.yaml
ubuntu-image classic --debug -O output/ image/core-desktop.yaml

INSTALLER_IMAGE=$PWD/output/plasma-core-desktop-installer-amd64.img

# Process obtained from https://itnext.io/how-to-create-a-custom-ubuntu-live-from-scratch-dd3b3f213f81

# where to mount the disk image
CHROOT=$PWD/output/mnt

mkdir -p $CHROOT
# since we know that the partition with the data is the third one, we use awk to extract the start sector
mount -o loop,offset=$(expr 512 \* $(fdisk -l ${INSTALLER_IMAGE} |grep img3 | awk '{print $2}')) ${INSTALLER_IMAGE} $CHROOT

# we prepare the chroot environment to ensure that everything works inside..
mount -o bind /dev ${CHROOT}/dev
mount -o bind /dev/pts ${CHROOT}/dev/pts
mount -o bind /proc ${CHROOT}/proc
mount -o bind /sys ${CHROOT}/sys
mount -o bind /run ${CHROOT}/run
# install the required packages
chroot ${CHROOT} apt install -y casper
# and, if needed, open a bash shell to do manual checks
# chroot ${CHROOT} /bin/bash
umount ${CHROOT}/run
umount ${CHROOT}/sys
umount ${CHROOT}/proc
umount ${CHROOT}/dev/pts
umount ${CHROOT}/dev

rm -rf $PWD/image2

mkdir -p $PWD/image2/casper
mkdir -p $PWD/image2/isolinux
mkdir -p $PWD/image2/install

mv $CHROOT/cdrom/casper/* $PWD/image2/casper/

cp $CHROOT/boot/vmlinuz-**-**-generic image2/casper/vmlinuz
cp $CHROOT/boot/initrd.img-**-**-generic image2/casper/initrd

touch image2/ubuntu

cat <<EOF > image2/isolinux/grub.cfg

search --set=root --file /ubuntu

insmod all_video

set default="0"
set timeout=3

menuentry "Install Ubuntu Core Desktop" {
   linux /casper/vmlinuz boot=casper quiet splash ---
   initrd /casper/initrd
}
EOF

mksquashfs $CHROOT image2/casper/filesystem.squashfs

printf $(du -sx --block-size=1 $CHROOT | cut -f1) > image2/casper/filesystem.size

# we are done with the original disk image
umount ${CHROOT}
rmdir ${CHROOT}

cd $PWD/image2

grub-mkstandalone \
   --format=x86_64-efi \
   --output=isolinux/bootx64.efi \
   --locales="" \
   --fonts="" \
   "boot/grub/grub.cfg=isolinux/grub.cfg"

(
   cd isolinux && \
   dd if=/dev/zero of=efiboot.img bs=1M count=10 && \
   mkfs.vfat efiboot.img && \
   LC_CTYPE=C mmd -i efiboot.img efi efi/boot && \
   LC_CTYPE=C mcopy -i efiboot.img ./bootx64.efi ::efi/boot/
)

grub-mkstandalone \
   --format=i386-pc \
   --output=isolinux/core.img \
   --install-modules="linux16 linux normal iso9660 biosdisk memdisk search tar ls" \
   --modules="linux16 linux normal iso9660 biosdisk search" \
   --locales="" \
   --fonts="" \
   "boot/grub/grub.cfg=isolinux/grub.cfg"

cat /usr/lib/grub/i386-pc/cdboot.img isolinux/core.img > isolinux/bios.img

/bin/bash -c "(find . -type f -print0 | xargs -0 md5sum | grep -v "\./md5sum.txt" > md5sum.txt)"

xorriso \
   -as mkisofs \
   -iso-level 3 \
   -full-iso9660-filenames \
   -volid "Ubuntu Core Desktop" \
   -output "${CORE_IMAGE%.*.*}.iso" \
   -eltorito-boot boot/grub/bios.img \
      -no-emul-boot \
      -boot-load-size 4 \
      -boot-info-table \
      --eltorito-catalog boot/grub/boot.cat \
      --grub2-boot-info \
      --grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img \
   -eltorito-alt-boot \
      -e EFI/efiboot.img \
      -no-emul-boot \
   -append_partition 2 0xef isolinux/efiboot.img \
   -m "isolinux/efiboot.img" \
   -m "isolinux/bios.img" \
   -graft-points \
      "/EFI/efiboot.img=isolinux/efiboot.img" \
      "/boot/grub/bios.img=isolinux/bios.img" \
      "."

