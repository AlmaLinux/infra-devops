# ----------------------------------------------------------------------------
# Multi stage build, using Micro version AlmaLinux as foundation for end image
# Final image designed for specific purposes, don't have dnf, microdnf or yum
# ----------------------------------------------------------------------------
FROM almalinux:8 as builder

RUN mkdir -p /mnt/system-root /mnt/system-root/build /mnt/system-root/run/lock; \
    dnf install --installroot /mnt/system-root  --releasever 8 --setopt=install_weak_deps=False --setopt=tsflags=nodocs -y coreutils-single \
    bash \
    glibc-minimal-langpack \
    anaconda-tui \
    lorax \
    subscription-manager \
    jq \
    tar \
    policycoreutils \
    pykickstart \
    # Optional include to avoid runtime warning -- starts
    libblockdev-mdraid  \
    libblockdev-crypto \
    libblockdev-lvm \
    libblockdev-dm \
    libblockdev-swap \
    libblockdev-loop \
    libblockdev-nvdimm \
    libblockdev-mpath \
    # Optional include to avoid runtime warning -- ends
    rootfiles \
    util-linux-ng; \
    rm -rf /mnt/system-root/var/cache/* ; \
    dnf clean all; \
    cp /etc/yum.repos.d/* /mnt/system-root/etc/yum.repos.d/ ; \
    rm -rf /var/cache/yum; \
    # TODO: commands below move to side script or remove?
    # generate build time file for compatibility with CentOS
    /bin/date +%Y%m%d_%H%M > /mnt/system-root/etc/BUILDTIME ;\
    # set DNF infra variable to container for compatibility with CentOS
    echo 'container' > /mnt/system-root/etc/dnf/vars/infra; \
    # install only en_US.UTF-8 locale files, see
    # https://fedoraproject.org/wiki/Changes/Glibc_locale_subpackaging for details
    echo '%_install_langs en_US.UTF-8' > /mnt/system-root/etc/rpm/macros.image-language-conf; \
    touch /mnt/system-root/etc/machine-id;

COPY scripts/ /mnt/system-root/usr/bin

# Create Final image from scratch for ks2rootfs
FROM scratch

COPY --from=builder /mnt/system-root/ /

WORKDIR /build

ENTRYPOINT ["/usr/bin/ks2rootfs"]
