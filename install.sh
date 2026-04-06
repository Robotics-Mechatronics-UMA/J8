#!/bin/bash
set -e

# ── ROS2 extras (no incluidos en ros-humble-desktop) ──────────────────────────
sudo apt-get update
sudo apt-get install -y \
  ros-humble-rmw-cyclonedds-cpp \
  python3-colcon-common-extensions \
  python3-rosdep \
  libopenblas-dev liblapack-dev

# Inicializar rosdep si no se ha hecho ya
if [ ! -f /etc/ros/rosdep/sources.list.d/20-default.list ]; then
  sudo rosdep init
fi
rosdep update

# ── LCM 1.5 (public repo) ─────────────────────────────────────────────────────
git clone --depth 1 --branch v1.5.0 https://github.com/lcm-proj/lcm.git /tmp/lcm
mkdir -p /tmp/lcm/build && cd /tmp/lcm/build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
sudo make install
sudo ldconfig
echo "LCM installation complete."
cd -
rm -rf /tmp/lcm

# ── GeographicLib (via apt) ────────────────────────────────────────────────────
sudo apt-get install -y geographiclib-tools libgeographic-dev
echo "geographiclib installation complete."

# ── ROS deps + Qt xcb ─────────────────────────────────────────────────────────
rosdep install --from-paths src --ignore-src -r -y
sudo apt-get install -y libxcb-xinerama0 libxcb-cursor0

# ── Python deps ───────────────────────────────────────────────────────────────
sudo apt-get install -y python3-pip
pip3 install cvxpy transforms3d PySide6 utm pyproj
