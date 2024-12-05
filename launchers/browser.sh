#!/bin/bash
x11docker --cap-default -I --hostdisplay -- --device nvidia.com/gpu=all -- local/x11docker-webnav nvidia-smi
