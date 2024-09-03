restart-wifi.sh
---

(Formerly at this gist: https://gist.github.com/sahal/78eaa73d07ac74de3aa22a889f90fe71)

I use this script because netctl is kinda annoying to use otherwise.

### Use

To use set the first parameter to a wifi name with a configuration already set and placed in `/etc/netctl`.

### Take an interface down

```
$ restart-wifi.sh down
```

**Hint**: Use an env var `${INTERFACE_NAME}` to specify an interface name.  The default is `wlp58s0`.

```
$ INTERFACE_NAME=wlp58s0 restart-wifi.sh down
```

### Connect to a pre-configured wifi-name

e.g. pre-configured wifi-name
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
