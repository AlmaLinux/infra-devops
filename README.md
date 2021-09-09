# Kickstart to RootFS Builder

This project provides the ability build `rootfs` file from `kickstart` input file in a docker/podman container environment. Output rootfs files can be used create base images for different OSs (AlmaLinux, Cent OS, Rocky Linux) etc.

## HOW-TO

Image yet ot published in `hub.docker.com`, until then use local build.

### Building local

```sh
docker build -t almalinux/ks2rootfs .
```

### Using Image

Following command under `tests` folder. Run command uses the `kickstarts/almalinux-8-default.x86_64.ks` file to build.

Use command below to create `default` docker files

```sh
docker run --rm --privileged -v "$PWD:/build:z" \
    -e KICKSTART_FILE=kickstarts/almalinux-8-default.x86_64.ks \
    -e IMAGE_NAME=almalinux-8-docker-default.x86_64.tar.gz \
    -e OUTPUT_DIR=default \
    almalinux/ks2rootfs
```

Use command below to create `minimal` docker files

```sh
docker run --rm --privileged -v "$PWD:/build:z" \
    -e KICKSTART_FILE=kickstarts/almalinux-8-minimal.x86_64.ks \
    -e IMAGE_NAME=almalinux-8-docker-minimal.x86_64.tar.gz \
    -e OUTPUT_DIR=minimal \
    almalinux/ks2rootfs
```

### Environment variables

Container startup script `ks2rootfs` supports multiple environment varible to customize the output. The environment variables and their use as follows

```sh
ENVIRONMENT VARIABLES:
======================

KICKSTART_FILE  : Reuired - Input kickstart source file (.ks)
IMAGE_NAME     : Required - Rootfs output file name 

BUILD_WORK_DIR   : Optional - Working dir for kickstart source and image destination. Defaults to current directory.
OUTPUT_DIR     : Optional - Output directory name in working directory. Ddefault value is 'result'.
FLAG_OUTOUT_IN_PWD : Optional - Set this flag to true to write output files in current working directory. Default value is false. When value is set to `true`, any value passed to `OUTPUT_DIR` will be ignored.
FLAG_WRITE_META    : Optional - Generate meta data about the kickstart build system. Default value is true.
FLAG_RETAIN_LOG    : Optional - Retain generated output log files under 'logs' output directory. Default value is false.


USAGE:
    ks2rootfs KICKSTART_FILE_NAME ROOTFS_FILE_NAME

EXAMPLES:
    ks2rootfs os-minimal.ks os-minimal.tar.xz
```
