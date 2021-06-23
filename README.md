# Kickstart to RootFS Builder

This project provides the ability build `rootfs` file from `kickstart` input file in a docker/podman container environment. Output rootfs files can be used create base images for different OSs (AlmaLinux, Cent OS, Rocky Linux) etc.

## HOW-TO

Image yet ot published in `hub.docker.com`, until then use local build.

### Building local

```sh
docker build -t srbala/ks2rootfs .
```

### Using Image

Following command uses the `kickstarts/almalinux-8-default.x86_64.ks` file to build.

```sh
docker run --rm --privileged -v "$PWD:/build:z" \
    -e BUILD_KICKSTART=kickstarts/almalinux-8-default.x86_64.ks \
    -e BUILD_ROOTFS=almalinux-8-default-docker.x86_64.tar.gz \
    srbala/ks2rootfs
```

### Environment variables

Container startup script `ks2rootfs` supports multiple environment varible to customize the output. The environment variables and their use as follows

```sh
ENVIRONMENT VARIABLES:
======================

BUILD_KICKSTART  : Input kickstart source file (.ks) - Required
BUILD_ROOTFS     : Rootfs output file name - Required

BUILD_WORK_DIR   : Working dir for kickstart source and image destination (default current directory) - Optional
BUILD_OUTDIR     : Output directory name in working dir - Optional
BUILD_FLAG_OUTOUT_IN_PWD : Set this flag to true to write output files in current working directory. Default value is 'false'. When value is set to 'true', any value passed to 'BUILD_OUTDIR' will be ignored.
BUILD_FLAG_WRITE_META    : Generate meta data about the kickstart build system - Optional
BUILD_FLAG_RETAIN_LOG    : Retain generated output log files under 'logs' output directory - Optional

USAGE:
    ks2rootfs KICKSTART_FILE_NAME ROOTFS_FILE_NAME

EXAMPLES:
    ks2rootfs os-minimal.ks os-minimal.tar.xz
```
