#!/bin/sh

if [ "$#" -ne 3 ] || ! [ -f "$1" ] || ! [ -f "$3" ]; then
  echo "Usage: $0 SNAP_FILE SNAP_NAME TESTSUITE_SCRIPT" >&2
  echo "  e.g: $0 ./kcalc_24.02.1_amd64.snap kcalc ./testsuite.py" >&2
  echo "Note, the installed snap will not be removed automatically" >&2
  exit 1
fi

# Install the snap package to test.
snap install kf6-core22 || exit 1
sudo snap install --dangerous "$1" || exit 1
sudo snap connect "$2":kf6-core22 kf6-core22:kf6-core22 || exit 1

# Run the testsuite
chmod +x "$3"
selenium-webdriver-at-spi-run "$3"