restart-wifi.sh
---

I use this script because netctl is kinda annoying to use otherwise.

### Change Wifi Device state


I've been turning off my wifi device using `ip` as follows:

```
ip link set wlp58s0 down
```

where `wlp58s0` is my wifi device.

### Use

To use set the first parameter to a wifi name with a configuration already set and placed in `/etc/netctl`

e.g.

```
$ sudo cat /etc/netctl/cplwifi
[sudo] password for sahal:
Description='Automatically generated profile by wifi-menu'
Interface=wlp58s0
Connection=wireless
Security=none
ESSID=CPLWIFI
IP=dhcp
```

### Take an interface down

```
$ restart-wifi.sh down
```

**Hint**: Use an env var `${INTERFACE_NAME}` to specify an interface name.  The default is `wlp58s0`.

```
$ INTERFACE_NAME=wlp58s0 restart-wifi.sh down
```

### Connect to a pre-configured wifi-name

```
$ restart-wifi.sh cplwifi
```

### Connect to a new wifi hotspot using wifi-menu

```
$ restart-wifi.sh menu
```

### List available pre-configured wifi-names

```
$ restart-wifi.sh list
```

### Tags

arch linux netctl wifi ip
