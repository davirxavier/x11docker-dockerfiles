FROM local/x11docker-xfce

RUN apt-get -y update && apt-get -y install git wget plank xz-utils sassc libglib2.0-dev libxml2-utils gnome-themes-extra gtk2-engines-murrine hicolor-icon-theme libgdk-pixbuf2.0-0 plank dconf-editor python3 && apt-get -y remove xfce4-panel

WORKDIR /tmp
RUN git clone https://github.com/vinceliuice/Orchis-theme.git
WORKDIR /tmp/Orchis-theme
RUN chmod +x install.sh && ./install.sh && cd .. && rm -rf Orchis-theme

WORKDIR /usr/share/themes
RUN wget 'https://raw.githubusercontent.com/vinceliuice/WhiteSur-gtk-theme/refs/heads/master/release/WhiteSur-Dark.tar.xz'
RUN xz --decompress WhiteSur-Dark.tar.xz && tar -xf WhiteSur-Dark.tar && rm WhiteSur-Dark.tar

WORKDIR /tmp
RUN git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git
WORKDIR /tmp/Tela-circle-icon-theme
RUN chmod +x install.sh && ./install.sh -d /usr/share/icons && cd .. && rm -rf Tela-circle-icon-theme

RUN sed -i 's%<property name="ThemeName" type="string" value="Raleigh"/>%<property name="ThemeName" type="string" value="WhiteSur-Dark"/>%' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
RUN sed -i 's%<property name="IconThemeName" type="string" value="Tango"/>%<property name="IconThemeName" type="string" value="Tela-circle"/>%' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml

RUN cat >/etc/xdg/autostart/config.desktop <<EOF
[Desktop Entry]
Type=Application
Name=System config
Exec=python3 /usr/share/getusername.py
Terminal=false
EOF

RUN echo "xfce4-sensors:/usr/share/applications/xfce4-sensors.desktop" > /usr/share/.plankcustomapps

ENV CUSTOM_LAUNCHERS_PATH=/usr/share/.plankcustomapps

RUN cat >/usr/share/getusername.py <<EOF
import subprocess
import os
import time
import shlex
import shutil

username = subprocess.check_output(['whoami']).decode('utf-8')[:-1]

homefolder = f'/home/{username}'
localfolder = f'{homefolder}/.local'
dockiconsfolder = f'{homefolder}/.config/plank/dock1/launchers'
customappsfile = '$CUSTOM_LAUNCHERS_PATH'
cfgdonefile = f'{localfolder}/cfgdone'
autostartfolder = f'/home/{username}/.config/autostart'

gesettingsschema = 'net.launchpad.plank.dock.settings'
gsettingspath = '/net/launchpad/plank/docks/dock1/'

if os.path.isfile(customappsfile):
    if not os.path.exists(dockiconsfolder):
        os.makedirs(dockiconsfolder)

    with open (customappsfile, 'r') as launchers:
        for appline in launchers:
            applinesplit = appline.split(':')
            if not os.path.isfile(f'{dockiconsfolder}/{applinesplit[0]}.dockitem') and applinesplit[1]:
                with open(f'{dockiconsfolder}/{applinesplit[0]}.dockitem', 'w+') as appitemfile:
                    appitemfile.write(f'[PlankDockItemPreferences]\nLauncher=file://{applinesplit[1]}')

if os.path.isfile(cfgdonefile):
    exit()

if not os.path.exists(autostartfolder):
    os.makedirs(autostartfolder)

subprocess.Popen(['plank', '&'], start_new_session=True, stdin=None, stdout=None, stderr=None, close_fds=True)
time.sleep(2)
shutil.copy('/usr/share/applications/plank.desktop', autostartfolder)

if not os.path.exists(localfolder):
    os.makedirs(localfolder)

if not os.path.exists(dockiconsfolder):
    os.makedirs(dockiconsfolder)

subprocess.Popen(['bash', '-c', f'gsettings set {gesettingsschema}:{gsettingspath} theme \'Gtk+\''])
subprocess.Popen(['bash', '-c', f'gsettings set {gesettingsschema}:{gsettingspath} zoom-enabled true'])
subprocess.Popen(['bash', '-c', f'gsettings set {gesettingsschema}:{gsettingspath} zoom-percent 135'])
subprocess.Popen(['bash', '-c', f'gsettings set {gesettingsschema}:{gsettingspath} icon-size 54'])
subprocess.Popen(['bash', '-c', 'xdg-mime default nemo.desktop inode/directory application'])

with open(cfgdonefile, 'w+') as cfgdone:
    cfgdone.write('1')

EOF
RUN chmod +x /usr/share/getusername.py
