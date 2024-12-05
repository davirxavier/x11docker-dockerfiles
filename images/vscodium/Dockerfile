#FROM debian:stable
FROM local/x11docker-xfce
RUN apt-get update -y && apt-get -y install curl wget rename

WORKDIR /usr/local/codium
RUN curl -s -L https://github.com/VSCodium/vscodium/releases/latest | grep "codium.*amd64.*deb<" | cut -d'"' -f2 | wget -i -
RUN rename 's/.*/codium.deb/' *.deb
RUN apt-get -y install ./codium.deb

RUN echo '#! /bin/bash \n\
CHILD="$*" \n\
[ -z "$CHILD" ] && CHILD="codium --no-sandbox" \n\
xpra start $DISPLAY --use-display  --dpi=72\
    --html=on --bind-tcp=$(hostname):15500 \
    --start-via-proxy=no --daemon=no \
    --start-child "$CHILD" --exit-with-children \n\
' > /usr/bin/start
RUN chmod +x /usr/bin/start
CMD start