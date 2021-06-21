# Kickstart to RootFS Builder

This project provides the ability build `rootfs` file from `kickstart` input file in a docker/podman container environment. Output rootfs files can be used create base images for different OSs (AlmaLinux, Cent OS, Rocky Linux) etc.

## HOW-TO

Image yet ot published in `hub.docker.com`, until then use local build.
### Building local
```
docker build -t srbala/ks2rootfs .
```

### Using Image

Following command uses the `kickstarts/almalinux-8-default.x86_64.ks` file to build.

```
docker run --rm --privileged -v "$PWD:/build:z" \
    -e BUILD_KICKSTART=kickstarts/almalinux-8-default.x86_64.ks \
    -e BUILD_ROOTFS=almalinux-8-default-docker.x86_64.tar.gz \
    srbala/ks2rootfs
```
