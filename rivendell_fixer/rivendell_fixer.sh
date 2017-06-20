#!/bin/bash

logfile=/home/wmfo-dj/rivendell-fixer.log
hostname=`hostname`

echo "Rivendell fixer script executing" >$logfile
date >>$logfile

echo "Welcome to the WMFO shit-broken-with-Rivendell fixer"
echo ""
sleep 2
echo "Checking to see if Rivendell is running..."
sleep 1

if rdairplay_pid=`pgrep rdairplay` ; then
	echo "Yessir it is! PID $rdairplay_pid; murdering..."
	kill -9 $rdairplay_pid
	echo "Killed rdairplay process PID $rdairplay_pid" >>$logfile
else
	echo "Nope, continuing..."
fi
sleep 1
lockfile=/home/wmfo-dj/.rdairplaylock
echo ""
echo "Checking for rdairplay lockfile..."
if [ -a $lockfile ] ; then
	echo "Ahoy! Found her. Destroying..."
	rm -f $lockfile
	echo "Removed rdairplay lock file" >>$logfile
else 
	echo "No dice..."
fi
sleep 1
echo ""
echo "Restarting rivendell daemons"

sudo /usr/sbin/service rivendell restart

echo ""
echo "Verifying everything is all hunky-dory..."

if status=`/usr/sbin/service rivendell status` ; then
	echo "Looks like there's smooth sailing!"
else
	# send the mailz`
	echo "Womp womp. There's a problem. The ops list has been notified."
	echo "Error! Rivendell services failed to start. Status:">>$logfile
	echo "$status">>$logfile
	cat $logfile | mail -s "Rivendell failed to start on $hostname" root
	read -p "Press any key to exit." -n1 -s
	exit
fi
sleep 1
	
echo ""
echo "Starting rdairplay"
/usr/bin/setsid /usr/local/bin/rdairplay &

echo "rdairplay started, god speed"
echo "rdairplay started" >> $logfile
echo ""
cat $logfile | mail -s "Rivendell fixer executed successfully on $hostname" root
sleep 3
read -p "Script completed successfully. Press any key to exit." -n1 -s

