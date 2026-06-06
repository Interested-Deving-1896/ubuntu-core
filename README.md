[update-readmes]   Mode: rewrite — migrating to template structure...
# ubuntu-core

[![Built with Ona](https://ona.com/build-with-ona.svg)](https://app.ona.com/#https://github.com/Interested-Deving-1896/ubuntu-core)

<!-- AI:start:what-it-does -->
This project automates the creation of Ubuntu-based core images tailored for KDE Neon environments. It provides scripts and configurations to generate signed and "dangerous" images, tar archives, and ISO files for deployment. It is used by developers and system integrators working with KDE Neon to streamline image generation and signing processes.
<!-- AI:end:what-it-does -->

## Architecture

<!-- AI:start:architecture -->
The project builds Ubuntu Core images tailored for KDE Neon. It uses a `Makefile` to define build targets for generating "dangerous" and "signed" images, both as `.tar.gz` archives and `.iso` files. The process involves creating model assertion files, signing them, generating snap lists, and assembling images using `ubuntu-image`. Additional scripts handle JSON finalization, snap list creation, and ISO generation.

Key components:
- **Makefile**: Defines build targets and dependencies for image creation.
- **Scripts**: Includes `create-snap-list.sh`, `finalize-json.sh`, and `create_iso.sh` for auxiliary tasks.
- **Configuration Files**: Contains `kde-neon-core-amd64.json` and YAML templates for image customization.
- **Output Artifacts**: Generated images and archives are stored in the repository root or `output/`.

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
   - Executes the `Makefile` targets to build `dangerous` and `signed` images.  
   - Artifacts generated include `.tar.gz` and `.iso` files for both `dangerous` and `signed` builds.  
   - No secrets required.

2. **`test.yml`**:  
   - Runs on pull requests.  
   - Validates the integrity of generated `.model` and `.snap-list` files.  
   - Ensures `finalize-json.sh` and `create-snap-list.sh` scripts execute without errors.  
   - No secrets required.

3. **`release.yml`**:  
   - Triggers on the creation of a new Git tag.  
   - Builds and uploads release artifacts (`.tar.gz` and `.iso` files) to the GitHub release.  
   - Requires the `GITHUB_TOKEN` secret (provided by default in GitHub Actions).  

All workflows are defined in the `.github/workflows` directory.
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
[@er-vin](https://github.com/er-vin) - 18 commits  
[@Interested-Deving-1896](https://github.com/Interested-Deving-1896) - 14 commits  
[@DaSpood](https://github.com/DaSpood) - 2 commits  
[@bport](https://github.com/bport) - 1 commit  

*Note: This repository may be a mirror. Please check the upstream source for additional context.*
<!-- AI:end:contributors -->

## Origins

<!-- AI:start:origins -->
_No dependency graph found. Run `generate-dep-graph.yml` to generate `dep-graph/origins.md`._
<!-- AI:end:origins -->

## Resources

<!-- AI:start:resources -->
_No additional resource files found._
<!-- AI:end:resources -->

## License

<!-- AI:start:license -->
<!-- License not detected — add a LICENSE file to this repo. -->
<!-- AI:end:license -->
