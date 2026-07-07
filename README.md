[update-readmes]   Mode: rewrite — migrating to template structure...
# ubuntu-core

[![Built with Ona](https://ona.com/build-with-ona.svg)](https://app.ona.com/#https://github.com/Interested-Deving-1896/ubuntu-core)

<!-- AI:start:what-it-does -->
This project automates the creation of Ubuntu-based core images tailored for KDE Neon environments. It provides tools to generate signed and "dangerous" images, tarballs, and ISO files for deployment. Developers and system integrators use it to streamline the process of building and packaging customized operating system images.
<!-- AI:end:what-it-does -->

## Architecture

<!-- AI:start:architecture -->
The project builds Ubuntu Core images tailored for KDE Neon. It uses a `Makefile` to define build targets for "dangerous" and "signed" images, generating `.tar.gz`, `.iso`, and `.img` files. The process involves signing JSON model files, creating snap lists, and assembling images using `ubuntu-image`. Scripts like `finalize-json.sh` and `create-snap-list.sh` assist in preparing inputs for the build.

Key components:
- **Makefile**: Defines build rules and dependencies.
- **Scripts**: Automate JSON finalization, snap list creation, and ISO generation.
- **Image Directory**: Contains YAML templates for image configuration.
- **JSON Files**: Define image models and configurations.

Directory structure:
```plaintext
.
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
└── run-image.sh
```
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
   - Triggers on push and pull request events.  
   - Runs the `Makefile` targets to build `dangerous` and `signed` artifacts.  
   - Validates the build process and ensures no errors in the generated files.  

2. **`lint.yml`**:  
   - Triggers on push and pull request events.  
   - Lints all shell scripts in the repository using `shellcheck`.  
   - Ensures code quality and adherence to shell scripting best practices.  

### Required Secrets
- `KDE_SNAPCRAFT_KEY`: Used for signing `.model` files during the build process.  
- `KDE_NEON_CORE_IMAGE_KEY`: Used for signing additional `.model` files.  

Ensure these secrets are configured in the repository settings for workflows to execute successfully.
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
