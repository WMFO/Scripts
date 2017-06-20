#!/bin/bash

export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)

for i in `seq 0 4`;
do
	/usr/bin/curl -s -u user:opsteam http://192.168.0.110/cgi-bin/cgi_dsts | grep "name=R007_RURL" | grep -c 10500 > /dev/null
	if [ $? -ne 0 ] ; then
		/usr/bin/notify-send "Studio A OFF AIR!" "The board is inactive. See the 'Oh Shit, It Broke' manual under 'Switch Studios' for information and how to put Studio A back ON AIR!" -i /opt/wmfo/macro_sh/off_air.jpg
	
	fi
	sleep 12
done
