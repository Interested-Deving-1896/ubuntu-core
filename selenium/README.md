- put the snap package to test in the current directory, renaming it `testsnap.snap`
- put the python test script to run with Selenium in the current directory, renaming it `testsuite.py`
- launch `run.sh`, which will build the docker image and run a container in which the tests can be launched

Currently: container fails to start, `systemd` struggles with cgroups.