#!/bin/bash

X11DOCKER_IMAGE_NAME=$(echo "$1" | sed "s%/%-%")
X11DOCKERFILE_PATH=$2
X11DOCKER_CMD=$3

OLD_MD5=$(cat "$X11DOCKERFILE_PATH/$X11DOCKER_IMAGE_NAME.md5" 2>&-)
NEW_MD5=$(md5sum "$X11DOCKERFILE_PATH/Dockerfile" | cut -d' ' -f1)

echo "New/old MD5 for Dockerfile $2/Dockerfile: $NEW_MD5 / $OLD_MD5"

if [ "$OLD_MD5" != "$NEW_MD5" ]; then
    echo "MD5 has changed, rebuilding image."

    if [ -f "$X11DOCKERFILE_PATH/build.sh" ]; then
        "$X11DOCKERFILE_PATH/build.sh"
    else
        podman build "$X11DOCKERFILE_PATH" -t "$X11DOCKER_IMAGE_NAME"
    fi

    md5sum "$X11DOCKERFILE_PATH/Dockerfile" | cut -d' ' -f1 > "$X11DOCKERFILE_PATH/$X11DOCKER_IMAGE_NAME.md5"
fi

bash -c "$X11DOCKER_CMD"
