[update-readmes]   Mode: rewrite — migrating to template structure...
# ubuntu-core

[![Built with Ona](https://ona.com/build-with-ona.svg)](https://app.ona.com/#https://github.com/Interested-Deving-1896/ubuntu-core)

<!-- AI:start:what-it-does -->
This project provides tools and configurations for building Ubuntu Core images tailored for KDE Neon environments. It automates the creation of signed and "dangerous" (unsigned) system images, tarballs, and ISO files, enabling developers and system integrators to generate customized, minimal operating system images for deployment. It is primarily used by those working on KDE Neon or related projects requiring Ubuntu Core-based distributions.
<!-- AI:end:what-it-does -->

## Architecture

<!-- AI:start:architecture -->
The project builds Ubuntu Core images tailored for KDE Neon. It uses a `Makefile` to define build targets for generating "dangerous" and "signed" images, as well as their corresponding ISO files. The process involves creating model assertion files, signing them, generating snap lists, building images, and optionally compressing or packaging them into ISOs. Scripts like `finalize-json.sh` and `create-snap-list.sh` handle intermediate steps. The `ubuntu-image` tool is used for image creation.

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
└── run-image.sh
```

Key components:
- **Makefile**: Defines build targets and dependencies.
- **Scripts**: Automate JSON finalization, snap list creation, and ISO generation.
- **`ubuntu-image`**: Used for building images from model assertions and snap lists.
- **`image/`**: Contains configuration templates for image creation.
- **`local-snaps/`**: Stores local snap packages for inclusion in the images.
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

1. **`build.yml`**  
   - Triggers: On push and pull request to `main` branch.  
   - Tasks: Runs the `Makefile` targets to build `dangerous` and `signed` tarballs and ISOs.  
   - Required Secrets: None.

2. **`lint.yml`**  
   - Triggers: On push and pull request to any branch.  
   - Tasks: Lints shell scripts (`*.sh`) using `shellcheck`.  
   - Required Secrets: None.

3. **`release.yml`**  
   - Triggers: On creating a new Git tag.  
   - Tasks: Builds release artifacts (`*.tar.gz` and `*.iso`) and uploads them as release assets.  
   - Required Secrets: `GITHUB_TOKEN` (provided by default in GitHub Actions).

Ensure all required secrets are configured in the repository settings before running workflows.
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
[@Interested-Deving-1896](https://github.com/Interested-Deving-1896) - 24 commits  
[@er-vin](https://github.com/er-vin) - 18 commits  
[@DaSpood](https://github.com/DaSpood) - 2 commits  
[@bport](https://github.com/bport) - 1 commit  

*Note: This repository may be a mirror. Please refer to the upstream source for additional context.*
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
