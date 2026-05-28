[update-readmes]   Mode: rewrite — migrating to template structure...
# ubuntu-core

[![Built with Ona](https://ona.com/build-with-ona.svg)](https://app.ona.com/#https://github.com/Interested-Deving-1896/ubuntu-core)

<!-- AI:start:what-it-does -->
This project automates the creation of Ubuntu-based core images tailored for KDE Neon environments. It provides scripts and configurations to generate signed and "dangerous" images, tar archives, and ISO files for deployment. It is used by developers and system integrators working with KDE Neon to streamline image generation and signing processes.
<!-- AI:end:what-it-does -->

## Architecture

<!-- AI:start:architecture -->
_Architecture documentation pending._
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
   - Tasks: Runs the `Makefile` targets to build `dangerous` and `signed` images.  
   - Required Secrets: None.

2. **`release.yml`**  
   - Triggers: On creating a new GitHub release.  
   - Tasks: Builds release artifacts (`.tar.gz` and `.iso` files) and uploads them as release assets.  
   - Required Secrets: `KDE_SNAPCRAFT_KEY` (used for signing models).

3. **`lint.yml`**  
   - Triggers: On push and pull request to any branch.  
   - Tasks: Lints shell scripts (`*.sh`) using `shellcheck`.  
   - Required Secrets: None.

Ensure the required secrets are configured in the repository settings under "Settings > Secrets and variables > Actions".
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
[@DaSpood](https://github.com/DaSpood) - 2 commits  
[@bport](https://github.com/bport) - 1 commit  
[@Interested-Deving-1896](https://github.com/Interested-Deving-1896) - 1 commit  

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
