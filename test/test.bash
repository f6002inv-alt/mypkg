#!/bin/bash

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws

source /opt/ros/humble/setup.bash

colcon build --packages-select person_msgs --symlink-install

source install/setup.bash

colcon build --symlink-install

source install/setup.bash
source install/local_setup.bash

export PYTHONPATH=$PYTHONPATH:$dir/ros2_ws/install/person_msgs/local/lib/python3.10/dist-packages
export PYTHONPATH=$PYTHONPATH:$dir/ros2_ws/install/person_msgs/lib/python3.10/site-packages

timeout 15 ros2 launch mypkg talk_listen.launch.py > /tmp/mypkg.log
cat /tmp/mypkg.log
cat /tmp/mypkg.log | grep 'Listen:'
