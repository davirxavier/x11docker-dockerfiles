#!/bin/bash
[ ! -f idea.tar.gz ] || [ "$(md5sum idea.tar.gz | cut -d' ' -f1)" != "$(cat idea.md5)" ] && wget -O idea.tar.gz https://download.jetbrains.com/idea/ideaIU-2024.3.tar.gz && md5sum idea.tar.gz | cut -d' ' -f1 > idea.md5
[ ! -f rustrover.tar.gz ] || [ "$(md5sum rustrover.tar.gz | cut -d' ' -f1)" != "$(cat rustrover.md5)" ] && wget -O rustrover.tar.gz https://download-cdn.jetbrains.com/rustrover/RustRover-2024.3.tar.gz && md5sum rustrover.tar.gz | cut -d' ' -f1 > rustrover.md5
[ ! -f pycharm.tar.gz ] || [ "$(md5sum pycharm.tar.gz | cut -d' ' -f1)" != "$(cat pycharm.md5)" ] && wget -O pycharm.tar.gz https://download.jetbrains.com/python/pycharm-community-2024.3.tar.gz && md5sum pycharm.tar.gz | cut -d' ' -f1 > pycharm.md5
[ ! -f codium.deb ] && curl -s -L https://github.com/VSCodium/vscodium/releases/latest | grep "codium.*amd64.*deb<" | cut -d'"' -f2 | wget -O codium.deb -i -
[ ! -f gitkraken.deb ] && wget -O gitkraken.deb https://release.gitkraken.com/linux/gitkraken-amd64.deb
podman build ../xfce-base-themed -t local/x11docker-xfce-themed
podman build . -t local/x11docker-devel
