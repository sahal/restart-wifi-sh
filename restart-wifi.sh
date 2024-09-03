#!/usr/bin/env bash

set -u
set -e

export WIFI_NAME="${1:-unset}"

if [[ "${INTERFACE_NAME:-unset}" == "unset" ]]; then
  INTERFACE_NAME="wlp58s0"
fi

echo "WIFI_NAME: ${WIFI_NAME}, INTERFACE_NAME: ${INTERFACE_NAME}"

case "${WIFI_NAME}" in

  down)

    echo "Provided WIFI_NAME was 'down.' Instead of connecting, I will
    take the wifi interface down."
    echo
    sudo ip link set "${INTERFACE_NAME}" down
    echo
    ip a | grep "${INTERFACE_NAME}"

  ;;

  list)

    echo "Provided WIFI_NAME was 'list.' Instead of connecting, I will
    list the available netctl configs."
    echo
    find /etc/netctl -maxdepth 1 -type f | sed s@/.*/@@|sort | less

  ;;

  menu)

    echo "Provided WIFI_NAME was 'menu.' Instead of connecting, I will
    run 'wifi-menu.'"
    echo
    echo "Interface should be DOWN before we attempt to connect. 👀"
    echo
    sudo wifi-menu

  ;;

  # MmmMM, parameter expansion
  unset|help)

    echo "$0 [help|unset|down|menu|list|<wifi name>]"
    echo
    echo "Set a wifi name as the first positional parameter"
    echo
    echo "Special wifi names include menu, down and list."
    echo "-----------------------------------------------"
    echo "menu: run 'wifi-menu'"
    echo "down: shut down interface \${INTERFACE_NAME}"
    echo "list: list config files in /etc/netctl"
    echo
    echo
    exit 1

  ;;

  *)

    sudo systemctl stop "netctl@${WIFI_NAME}.service"

    sleep 4s

    sudo systemctl start "netctl@${WIFI_NAME}.service"

    sleep 4s

    sudo systemctl status "netctl@${WIFI_NAME}.service"

    watch 'ip a'
  ;;

esac
