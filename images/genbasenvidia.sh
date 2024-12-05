#! /bin/bash

# Script to build image x11docker/nvidia-base
# containing NVIDIA driver version matching the one on host.

Imagename="local/x11docker-nvidia-base"

Nvidiaversion="$(head -n1 </proc/driver/nvidia/version | awk '{ print $8 }')"
[ "$Nvidiaversion" ] || {
  echo "Error: No NVIDIA driver detected on host" >&2
  exit 1
}
echo "Detected NVIDIA driver version: $Nvidiaversion"

Driverurl="https://http.download.nvidia.com/XFree86/Linux-x86_64/$Nvidiaversion/NVIDIA-Linux-x86_64-$Nvidiaversion.run"
echo "Driver download URL: $Driverurl"

Tmpdir="/tmp/x11docker-nvidia-base"
mkdir -p "$Tmpdir"

echo "# Dockerfile to create NVIDIA driver base image $Imagename
FROM debian:bullseye
RUN apt-get update && \
    apt-get install --no-install-recommends -y kmod xz-utils wget ca-certificates binutils vainfo || exit 1 ; \
    wget $Driverurl -O /tmp/NVIDIA-installer.run || exit 1 ; \
    Nvidiaoptions='--accept-license --no-runlevel-check --no-questions --no-backup --ui=none --no-kernel-module --no-nouveau-check' ; \
    sh /tmp/NVIDIA-installer.run -A | grep -q -- '--install-libglvnd'        && Nvidiaoptions=\"\$Nvidiaoptions --install-libglvnd\" ; \
    sh /tmp/NVIDIA-installer.run -A | grep -q -- '--no-nvidia-modprobe'      && Nvidiaoptions=\"\$Nvidiaoptions --no-nvidia-modprobe\" ; \
    sh /tmp/NVIDIA-installer.run -A | grep -q -- '--no-kernel-module-source' && Nvidiaoptions=\"\$Nvidiaoptions --no-kernel-module-source\" ; \
    sh /tmp/NVIDIA-installer.run \$Nvidiaoptions || { echo 'ERROR: Installation of NVIDIA driver failed.' >&2 ; exit 1 ; } ; \
    rm /tmp/NVIDIA-installer.run ; \
    apt-get remove -y kmod xz-utils wget ca-certificates binutils ; \
    apt-get autoremove -y ; apt-get clean -y
" >"$Tmpdir/Dockerfile"

echo "Creating docker image $Imagename"
podman build -t $Imagename $Tmpdir || {
  echo "Error: Failed to build image $Imagename.
  Check possible build error messages above.
  Make sure that you have permission to start docker.
  Make sure docker daemon is running." >&2
  rm -R "$Tmpdir"
  exit 1
}

echo "Successfully created $Imagename"
rm -R "$Tmpdir"
exit 0
