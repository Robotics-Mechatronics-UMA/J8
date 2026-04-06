#!/usr/bin/env bash
set -e

export ROS_DOMAIN_ID="${ROS_DOMAIN_ID:-0}"
export RMW_IMPLEMENTATION="${RMW_IMPLEMENTATION:-rmw_cyclonedds_cpp}"
export CYCLONEDDS_URI="${CYCLONEDDS_URI:-file:///etc/cyclonedds/local_cyclonedds.xml}"

if command -v dbus-daemon >/dev/null 2>&1; then
  mkdir -p /run/dbus
  if [ ! -S /run/dbus/system_bus_socket ]; then
    dbus-daemon --system --fork
  fi
fi

source /opt/ros/humble/setup.bash
source /ros2_ws/install/setup.bash

exec "$@"
