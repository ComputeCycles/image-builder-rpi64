FROM hypriot/image-builder:latest

ENV HYPRIOT_OS_VERSION=v2.1.0 \
    RAW_IMAGE_VERSION=v0.3.1

#Note that the checksums and build timestamps only apply when fetching missing
#artifacts remotely is enabled to validate downloaded remote artifacts
ENV FETCH_MISSING_ARTIFACTS=true \
    ROOT_FS_ARTIFACT=rootfs-arm64-debian-20190922.tar.gz \
    KERNEL_ARTIFACT=4.14.114-hypriotos-v8.tar.gz \
    BOOTLOADER_ARTIFACT=rpi-bootloader.tar.gz \
    RAW_IMAGE_ARTIFACT=rpi-raw.img.zip \
    DOCKER_ENGINE_VERSION="5:19.03.1~3-0~debian-buster" \
    CONTAINERD_IO_VERSION="1.2.6-3" \
    DOCKER_COMPOSE_VERSION="1.23.1" \
    DOCKER_MACHINE_VERSION="0.16.1" \
    KERNEL_VERSION="4.14.114" \
    ROOTFS_TAR_CHECKSUM="88a00c7434ce15aa55aaccc787d27ee7c2e8a3001fac99e9cf519ab7bd08cda6" \
    RAW_IMAGE_CHECKSUM="f911e08e9dc83a8f727c5e4200ad0c04c792a6f2bffd240d2a88444a5d98ee69" \
    BOOTLOADER_BUILD="20190922-151722" \
    KERNEL_BUILD="20190922-010958"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    binfmt-support \
    qemu \
    qemu-user-static \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ADD https://github.com/gruntwork-io/fetch/releases/download/v0.1.0/fetch_linux_amd64 /usr/local/bin/fetch
RUN chmod +x /usr/local/bin/fetch

COPY builder/ /builder/

# build sd card image
CMD /builder/build.sh
