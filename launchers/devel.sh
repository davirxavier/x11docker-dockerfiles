#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
$SCRIPT_DIR/update_and_run.sh "local/x11docker-devel" "$SCRIPT_DIR/../images/devel" "x11docker --desktop -I --homebasedir=$SCRIPT_DIR --home --share /home/$USER/Documents/Shared --share /home/$USER/Documents/git --share /home/$USER/Pictures/bg --clipboard=yes -- --cpus=6 -- local/x11docker-devel"
