# Scripts

- `./install_selenium.sh` will install all required dependencies and build the KDE Selenium wrapper
- `./run_selenium.sh <snap file> <app name> <testsuite script>` will install the provided snap file, connect kf6-core22 and run the selenium testsuite on it
- `./kcalc_24_tests.py` is an example testsuite for kcalc, adapted to work with the 24.02 version (breaking changes since the original 23.08 version)

## Important:

- The run script will not remove the test snap after running the tests. This could probably be changed for the CI.
- The installation script requires up-to-date packages available through `apt`, it was tested to work on KDE Neon, it failed on various "default" ubuntu versions (22.04, 22.10, 23.04, 24.04) even with the neon repository
- In case of an error with the symbol `ORG_KDE_KWIN_FAKE_INPUT_DESTROY_SINCE_VERSION` during installation, make sure package `plasma-wayland-protocols` is up to date