# KDE Neon Core Image Building

This repository contains all that's needed to build and run images provided the system has the right dependencies.

## Building images

There are two grades of images: signed and dangerous. Using `make <grade>` to build one of the two images. `make` or `make all` will build both the dangerous and the signed images. They will also be automatically compressed in `tar.gz` format at the end of the process.

### Signatures and keys

Signatures will occur during this process. This requires having an Ubuntu One account as described here:

https://ubuntu.com/core/docs/create-ubuntu-one

This also requires having registered keys, as described in the first two steps of this page:

https://ubuntu.com/core/docs/sign-model-assertion

The `Makefile` will handle the rest for you but it assumes your key to be created with the name `kde-neon-core-image-key`.

Also, no build can occur if you're not authenticated in your Ubuntu One account with `snapcraft`. To sanity check this, running `snapcraft whoami` will tell you under which account you are authenticated.

### dangerous vs signed

Whatever image variant you build, despite what the name seems to imply, some signature will occur. So they both require a valid key as described in the previous section.

The main difference between the dangerous and the signed images is the amount of freedom you get as to their content. The signed image will contain only the snaps listed in `kde-neon-core-amd64.json`. The dangerous image allows you to inject extra snaps or override some of the snaps of the list with locally built one.

As a developer, `make dangerous` is probably what you will want to use most of the time. To inject or override snaps, simply drop your own snaps in the `local-snaps` directory. Any snap in this directory will be injected in the dangerous image.

## Running images

Simply run the `run-image.sh` script passing the image as parameter. For instance:

```
./run-image.sh kde-neon-core-dangerous-amd64.img
```

## Dependencies

For building images:

* snap
* snapcraft
* ubuntu-image
* make
* jq
* date
* tar
* gzip

For running images:

* qemu-system-x86_64

