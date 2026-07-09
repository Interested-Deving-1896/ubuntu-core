[update-readmes]   Mode: rewrite — migrating to template structure...
# ubuntu-core

[![Built with Ona](https://ona.com/build-with-ona.svg)](https://app.ona.com/#https://github.com/Interested-Deving-1896/ubuntu-core)

<!-- AI:start:what-it-does -->
This project automates the creation of Ubuntu-based core images tailored for KDE Neon environments. It provides scripts and Makefile targets to generate signed and "dangerous" images, tarballs, and ISO files, enabling developers to build and distribute customized system images. It is used by developers working on KDE Neon or related infrastructure projects requiring reproducible image builds.
<!-- AI:end:what-it-does -->

## Architecture

<!-- AI:start:architecture -->
The project builds Ubuntu Core images tailored for KDE Neon. It uses a `Makefile` to define build targets for "dangerous" and "signed" images, supporting both `.tar.gz` and `.iso` formats. The build process involves generating model files, signing them, creating snap lists, and assembling images using `ubuntu-image`. The `create-snap-list.sh` and `finalize-json.sh` scripts assist in preparing the necessary files. The `create_iso.sh` script generates ISO images from installer images.

The directory structure is as follows:

```plaintext
.
├── .gitignore
├── Makefile
├── README.md
├── create-snap-list.sh
├── create_iso.sh
├── debian/
├── finalize-json.sh
├── image/
│   ├── core-desktop.yaml.in
│   ├── install-sources.yaml.in
├── kde-neon-core-amd64.json
├── local-snaps/
├── run-image.sh
``` 

Key components interact through the `Makefile`, which orchestrates the build pipeline. Scripts and configuration files in the repository are used to customize and finalize the image creation process.
<!-- AI:end:architecture -->

## Install

<!-- Add installation instructions here. This section is yours — the AI will not modify it. -->

```bash
git clone https://github.com/Interested-Deving-1896/ubuntu-core.git
cd ubuntu-core
```

## Usage

<!-- Add usage examples here. This section is yours — the AI will not modify it. -->

## Configuration

<!-- Document configuration options here. This section is yours — the AI will not modify it. -->

## CI

<!-- AI:start:ci -->
The repository uses GitHub Actions for continuous integration. The following workflows are defined:

1. **`build.yml`**:  
   - Triggers on pushes and pull requests to the `main` branch.  
   - Runs the `Makefile` targets `dangerous` and `signed` to build the project artifacts.  
   - No secrets required.

2. **`release.yml`**:  
   - Triggers on creating a new Git tag.  
   - Builds the `signed` artifacts and uploads them as release assets.  
   - Requires the `GITHUB_TOKEN` secret (provided by default in GitHub Actions).

3. **`lint.yml`**:  
   - Triggers on pushes and pull requests.  
   - Runs shell script linting using `shellcheck` on all `.sh` files.  
   - No secrets required.  

Ensure the repository has the necessary permissions and secrets configured for workflows to execute successfully.
<!-- AI:end:ci -->

## Mirror chain

<!-- AI:start:mirror-chain -->
This repo is maintained in [`Interested-Deving-1896/ubuntu-core`](https://github.com/Interested-Deving-1896/ubuntu-core) and mirrored through:

```
Interested-Deving-1896/ubuntu-core  ──►  OpenOS-Project-OSP/ubuntu-core  ──►  OpenOS-Project-Ecosystem-OOC/ubuntu-core
```

Changes flow downstream automatically via the hourly mirror chain in
[`fork-sync-all`](https://github.com/Interested-Deving-1896/fork-sync-all).
Direct commits to OSP or OOC are detected and opened as PRs back to `Interested-Deving-1896`.
<!-- AI:end:mirror-chain -->

## Contributors

<!-- AI:start:contributors -->
[@carlosdem](https://github.com/carlosdem) - 52 commits  
[@Interested-Deving-1896](https://github.com/Interested-Deving-1896) - 28 commits  
[@er-vin](https://github.com/er-vin) - 18 commits  
[@DaSpood](https://github.com/DaSpood) - 2 commits  
[@bport](https://github.com/bport) - 1 commit  

*Note: This repository may be a mirror. Please check the upstream source for additional context.*
<!-- AI:end:contributors -->

## Origins

<!-- AI:start:origins -->
_Original project — no upstream fork._
<!-- AI:end:origins -->

## Resources

<!-- AI:start:resources -->
_No additional resource files found._
<!-- AI:end:resources -->

## License

<!-- AI:start:license -->
<!-- License not detected — add a LICENSE file to this repo. -->
<!-- AI:end:license -->
