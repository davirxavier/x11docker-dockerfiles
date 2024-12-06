#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

[ ! -f codium.deb ] && curl -s -L https://github.com/VSCodium/vscodium/releases/latest | grep "codium.*amd64.*deb<" | cut -d'"' -f2 | wget -O $SCRIPT_DIR/codium.deb -i -
[ ! -f gitkraken.deb ] && wget -O $SCRIPT_DIR/gitkraken.deb https://release.gitkraken.com/linux/gitkraken-amd64.deb

podman build $SCRIPT_DIR/../xfce-base-themed -t local/x11docker-xfce-themed
podman build $SCRIPT_DIR -t local/x11docker-devel
