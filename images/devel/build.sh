#!/bin/bash
[ ! -f ideaIU-2024.3.tar.gz ] && wget https://download.jetbrains.com/idea/ideaIU-2024.3.tar.gz
[ ! -f RustRover-2024.3.tar.gz ] && wget https://download-cdn.jetbrains.com/rustrover/RustRover-2024.3.tar.gz
[ ! -f pycharm-community-2024.3.tar.gz ] && wget https://download.jetbrains.com/python/pycharm-community-2024.3.tar.gz
podman build ../x11docker-xfce-themed -t local/x11docker-xfce-themed
podman build . -t local/x11docker-devel
