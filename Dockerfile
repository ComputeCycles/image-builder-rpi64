FROM hypriot/image-builder:latest

ENV HYPRIOT_OS_VERSION=e16-20190205 \
    RAW_IMAGE_VERSION=v0.2.2

#Note that the checksums and build timestamps only apply when fetching missing
#artifacts remotely is enabled to validate downloaded remote artifacts
ENV FETCH_MISSING_ARTIFACTS=true \
    ROOT_FS_ARTIFACT=rootfs-arm64-debian-$HYPRIOT_OS_VERSION.tar.gz \
    KERNEL_ARTIFACT=4.14.95-hypriotos-v8.tar.gz \
    BOOTLOADER_ARTIFACT=rpi-bootloader.tar.gz \
    RAW_IMAGE_ARTIFACT=rpi-raw.img.zip \
    DOCKER_ENGINE_VERSION="18.04.0~ce~3" \
    DOCKER_COMPOSE_VERSION="1.21.1" \
    DOCKER_MACHINE_VERSION="0.14.0" \
    KERNEL_VERSION="4.14.95" \
    ROOTFS_TAR_CHECKSUM="b34da6f7f8683bf352d4e032667b3d8c2d05e459a91440fee7c2d17d7730eba5" \
    RAW_IMAGE_CHECKSUM="21d700beff39590f3a0b18874149110e4b2334d1256fa208dee4e4562518255d" \
    BOOTLOADER_BUILD="20180320-071222" \
    KERNEL_BUILD="20190131-160334"

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
