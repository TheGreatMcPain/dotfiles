#!/bin/sh
set -o errexit
set -o nounset

usage() {
  echo "Usage: $0 {-enable|-disable}"
}

if [ $# -ne 1 ]; then
  usage
  exit 1
fi

base_dir=/sys/bus/serio/drivers/psmouse
device_id=serio4

if [ $1 = "-disable" ]; then
  logger "$0 is disabling touchpad"
  echo -n manual > $base_dir/bind_mode
  echo -n $device_id > $base_dir/unbind 2>/dev/null || true
elif [ $1 = "-enable" ]; then
  logger "$0 is enabling touchpad"
  echo -n auto > $base_dir/bind_mode
else
  usage
  exit 1
fi
