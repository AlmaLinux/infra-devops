# Kickstart to RootFS Builder

This project provides the ability build `rootfs` file from `kickstart` input file in a docker/podman container environment. Output rootfs files can be used create base images for different OSs (AlmaLinux, Cent OS, Rocky Linux) etc.

## HOW-TO

Image yet ot published in `hub.docker.com`, until then use local build.

### Building local

```sh
docker build -t srbala/ks2rootfs:alma .
```

### Using Image

Following command under `tests` folder. Run command uses the `kickstarts/almalinux-8-default.x86_64.ks` file to build.

Use command below to create `default` docker files

```sh
docker run --rm --privileged -v "$PWD:/build:z" \
    -e BUILD_KICKSTART=kickstarts/almalinux-8-default.x86_64.ks \
    -e BUILD_ROOTFS=almalinux-8-docker-default.x86_64.tar.gz \
    -e BUILD_OUTDIR=default \
    srbala/ks2rootfs:alma
```

Use command below to create `minimal` docker files

```sh
docker run --rm --privileged -v "$PWD:/build:z" \
    -e BUILD_KICKSTART=kickstarts/almalinux-8-minimal.x86_64.ks \
    -e BUILD_ROOTFS=almalinux-8-docker-minimal.x86_64.tar.gz \
    -e BUILD_OUTDIR=minimal \
    srbala/ks2rootfs:alma
```

### Environment variables

Container startup script `ks2rootfs` supports multiple environment varible to customize the output. The environment variables and their use as follows

```sh
ENVIRONMENT VARIABLES:
======================

BUILD_KICKSTART  : Reuired - Input kickstart source file (.ks)
BUILD_ROOTFS     : Required - Rootfs output file name 

BUILD_WORK_DIR   : Optional - Working dir for kickstart source and image destination. Defaults to current directory.
BUILD_OUTDIR     : Optional - Output directory name in working directory. Ddefault value is 'result'.
BUILD_FLAG_OUTOUT_IN_PWD : Optional - Set this flag to true to write output files in current working directory. Default value is false. When value is set to `true`, any value passed to `BUILD_OUTDIR` will be ignored.
BUILD_FLAG_WRITE_META    : Optional - Generate meta data about the kickstart build system. Default value is true.
BUILD_FLAG_RETAIN_LOG    : Optional - Retain generated output log files under 'logs' output directory. Default value is false.


USAGE:
    ks2rootfs KICKSTART_FILE_NAME ROOTFS_FILE_NAME

EXAMPLES:
    ks2rootfs os-minimal.ks os-minimal.tar.xz
```
