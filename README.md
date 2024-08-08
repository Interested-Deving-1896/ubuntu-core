# KDE Neon Core Image Building

This repository contains all that's needed to build and run images provided the system has the right dependencies.

## Building images

There are two grades of images: signed and dangerous. Using `make <grade>` to build one of the two images. `make` or `make all` will build both the dangerous and the signed images. They will also be automatically compressed in `tar.gz` format at the end of the process. You can also use `make kde-neon-core-<grade>-amd64.img` to build the image without compression and without deleting temporary files.

### Signatures and keys

In order to build the image, a signed `.model` file needs to exist. Up-to-date models are provided in the repository.

After changing the `kde-neon-core-amd64.json` file, you will need to update these `kde-neon-core-<grade>-amd64.model` files.

#### Generating models with Make

The `Makefile` can handle that step for you if you call `make <model-file>`. Signatures will occur during this process. This requires having an Ubuntu One account as described here:

https://ubuntu.com/core/docs/create-ubuntu-one

This also requires having registered keys, as described in the first two steps of this page:

https://ubuntu.com/core/docs/sign-model-assertion

The Makefile assumes your key to be created with the name `kde-snapcraft-key`. Also, no build can occur if you're not authenticated in your Ubuntu One account with `snapcraft`. To sanity check this, running `snapcraft whoami` will tell you under which account you are authenticated.

#### Generating models with the CI

If Make is not a practical option for you, it is possible to let the CI handle the update of model files:

In the Gitlab web interface, go to the Pipelines page and click the "Run pipeline" button. This will take you to https://invent.kde.org/neon/ubuntu-core/-/pipelines/new. On this page, select your branch, and click the "Run pipeline" button again. In the pipeline view, you can click the "snap_image_model" job to manually start it.

Your branch needs to be protected, and its name needs to match the `models.*` pattern for the job to run.

Once the job is complete, it will upload both `dangerous` and `signed` versions of the model as pipeline artefacts, and push them to your branch in a "Update models" commit. Once you pull the commit, you will be able to build the full image locally.

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

