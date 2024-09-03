#!/usr/bin/env bash

set -u
set -e

export WIFI_NAME="${1:-unset}"

# its not possible that there would be a wifi hotspot called down
if [[ "${WIFI_NAME}" == "down" ]]; then

  echo "Provided WIFI_NAME was 'down.' Instead of connecting, I will
        take the wifi interface down."
  echo
  sudo ip link set wlp58s0 down
  echo
  ip a | grep wlp58s0

# its not possible that there would be a wifi hotspot called down
elif [[ "${WIFI_NAME}" == "list" ]]; then

  echo "Provided WIFI_NAME was 'list.' Instead of connecting, I will
        list the available netctl configs."
  echo
  find /etc/netctl -maxdepth 1 -type f | sed s@/.*/@@|sort | less

elif [[ "${WIFI_NAME}" == "menu" ]]; then

  echo "Provided WIFI_NAME was 'menu.' Instead of connecting, I will
  run 'wifi-menu.'"
  echo
  echo "Interface should be DOWN before we attempt to connect. 👀"
  echo
  sudo wifi-menu

else

  if [[ "${WIFI_NAME:-unset}" == "unset" ]]; then
    echo "Set a wifi name as the first positional parameter"
    exit 1
  fi

  sudo systemctl stop "netctl@${WIFI_NAME:-unset}.service"

  sleep 4s

  sudo systemctl start "netctl@${WIFI_NAME:-unset}.service"

  sleep 4s

  sudo systemctl status "netctl@${WIFI_NAME:-unset}.service"

  watch 'ip a'
fi
