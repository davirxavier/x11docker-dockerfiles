FROM local/x11docker-xfce-themed

RUN apt-get -y update
RUN apt-get -y purge thunar
RUN apt-get -y install wget tar nemo

WORKDIR /usr/local
COPY . .

RUN tar -xvzf ideaIU-2024.3.tar.gz
RUN rm ideaIU-2024.3.tar.gz
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

RUN tar -xvzf RustRover-2024.3.tar.gz
RUN rm RustRover-2024.3.tar.gz
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

RUN tar -xvzf pycharm-community-2024.3.tar.gz
RUN rm pycharm-community-2024.3.tar.gz
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

RUN echo "ideaui:/usr/share/applications/ideaiu.desktop\n\
rustrover:/usr/share/applications/rustrover.desktop\n\
pycharm:/usr/share/applications/pycharm.desktop" > "$CUSTOM_LAUNCHERS_PATH"
