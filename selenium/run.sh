# Adapting https://github.com/ogra1/snapd-docker/blob/master/build.sh
# Changes:
#   - Kept the clean_up function
#   - Kept the docker build and run commands
#   - Removed the use of arguments
#   - Removed the build-related sections of the script as we have a dedicated custom Dockerfile for that
#   - Replaced snapd healthcheck with container healthcheck
#   - Added use-case-specific commands at the end of the script

clean_up() {
    sleep 1
    docker logs -f snaptest > container_logs.txt || true
    docker rm -f snaptest >/dev/null 2>&1 || true
    docker rmi snaptest >/dev/null 2>&1 || true
    docker rmi $(docker images -f "dangling=true" -q) >/dev/null 2>&1 || true
    exit 1
}
trap clean_up 1 2 3 4 9 15

# Build the image
docker build -t snaptest --force-rm=true . || clean_up

# Start the detached container
docker run \
    --name=snaptest \
    -ti \
    --tmpfs /run \
    --tmpfs /run/lock \
    --tmpfs /tmp \
    --cap-add SYS_ADMIN \
    --device=/dev/fuse \
    --security-opt apparmor:unconfined \
    --security-opt seccomp:unconfined \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    -v /lib/modules:/lib/modules:ro \
    -d snaptest || clean_up

# FIXME:
#   systemd 249.11-0ubuntu3.12 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
#   Detected virtualization docker.
#   Detected architecture x86-64.
#
#   Welcome to Ubuntu 22.04.4 LTS!
#
#   Failed to create /init.scope control group: Read-only file system
#   Failed to allocate manager object: Read-only file system
#   Failed to allocate manager object.
#   Exiting PID 1...

# Wait for snapd to start
TIMEOUT=30
SLEEP=0.1
echo -n "Waiting up to $(($TIMEOUT/10)) seconds for container startup"
while [ "$( docker container inspect -f '{{.State.Status}}' snaptest )" != "running" ]; do
    echo -n "."
    sleep $SLEEP || clean_up
    if [ "$TIMEOUT" -le "0" ]; then
        echo " Timed out!"
        clean_up
    fi
    TIMEOUT=$(($TIMEOUT-1))
done
echo " done"

# Install test snap and kf6
docker exec snaptest snap install kf6-core22 || clean_up
docker exec snaptest snap install --dangerous testsnap.snap || clean_up
docker exec snaptest snap connect $SNAP_NAME:kf6-core22 kf6-core22:kf6-core22 || clean_up

# Run the tests
docker exec snaptest selenium-webdriver-at-spi-run testsuite.py > testsuite_output.txt
clean_up
