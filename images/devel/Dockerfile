FROM local/x11docker-xfce-themed

RUN apt-get -y update
RUN apt-get -y install wget tar curl rename flatpak midori build-essential

WORKDIR /usr/local

RUN wget -O idea.tar.gz https://download.jetbrains.com/idea/ideaIU-2024.3.tar.gz
RUN tar -xvzf idea.tar.gz
RUN rm idea.tar.gz
RUN chmod +x /usr/local/idea-IU-243.21565.193/bin/idea
RUN cat >/usr/share/applications/ideaiu.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ Idea Ultimate 2024.3
Exec=/usr/local/idea-IU-243.21565.193/bin/idea
Icon=/usr/local/idea-IU-243.21565.193/bin/idea.png
Categories=Development
EOL
RUN ln -s /usr/local/idea-IU-243.21565.193/bin/idea /usr/local/bin/ideaui

RUN wget -O rustrover.tar.gz https://download-cdn.jetbrains.com/rustrover/RustRover-2024.3.tar.gz
RUN tar -xvzf rustrover.tar.gz
RUN rm rustrover.tar.gz
RUN chmod +x /usr/local/RustRover-2024.3/bin/rustrover
RUN cat >/usr/share/applications/rustrover.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=RustRover 2024.3
Exec=/usr/local/RustRover-2024.3/bin/rustrover
Icon=/usr/local/RustRover-2024.3/bin/rustrover.png
Categories=Development
EOL
RUN ln -s /usr/local/RustRover-2024.3/bin/rustrover /usr/local/bin/rustrover

RUN wget -O pycharm.tar.gz https://download.jetbrains.com/python/pycharm-community-2024.3.tar.gz
RUN tar -xvzf pycharm.tar.gz
RUN rm pycharm.tar.gz
RUN chmod +x /usr/local/pycharm-community-2024.3/bin/pycharm
RUN cat >/usr/share/applications/pycharm.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=PyCharm Community 2024.3
Exec=/usr/local/pycharm-community-2024.3/bin/pycharm
Icon=/usr/local/pycharm-community-2024.3/bin/pycharm.png
Categories=Development
EOL
RUN ln -s /usr/local/pycharm-community-2024.3/bin/pycharm /usr/local/bin/pycharm

COPY codium.deb .
RUN apt-get -y install ./codium.deb
RUN rm codium.deb

COPY gitkraken.deb .
RUN apt-get -y install ./gitkraken.deb
RUN rm gitkraken.deb

RUN echo "ideaui:/usr/share/applications/ideaiu.desktop\n\
rustrover:/usr/share/applications/rustrover.desktop\n\
pycharm:/usr/share/applications/pycharm.desktop\n\
codium:/usr/share/applications/codium.desktop\n\
gitkraken:/usr/share/applications/gitkraken.desktop" > "$CUSTOM_LAUNCHERS_PATH"

RUN sed -i 's%Exec=/usr/share/codium/codium%Exec=/usr/share/codium/codium --no-sandbox%' /usr/share/applications/codium.desktop
RUN sed -i 's%Exec=/usr/share/codium/codium%Exec=/usr/share/codium/codium --no-sandbox%' /usr/share/applications/codium-url-handler.desktop

RUN sed -i 's%Exec=/usr/share/gitkraken/gitkraken%Exec=/usr/share/gitkraken/gitkraken --no-sandbox%' /usr/share/applications/gitkraken.desktop
RUN sed -i 's%Exec=/usr/share/gitkraken/gitkraken%Exec=/usr/share/gitkraken/gitkraken --no-sandbox%' /usr/share/applications/gitkraken-url-handler.desktop
