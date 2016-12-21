#!/bin/bash
set -e

nohup Xvfb :1 -screen 0 1024x768x16 &> xvfb.log &
DISPLAY=:1.0
export DISPLAY

source "/workspace/devel/setup.bash"
source "/usr/share/gazebo/setup.sh"

roslaunch smart_grasping_sandbox smart_grasping_sandbox.launch gui:=false gzweb:=true verbose:=true &

sleep 5

cd ~/gzweb
GAZEBO_MODEL_PATH=/workspace/src:/workspace/src/universal_robot:~/.gazebo/models:${GAZEBO_MODEL_PATH} ./start_gzweb.sh

# wait for any keu
read -n 1 -s