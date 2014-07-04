#!/bin/bash

PIDS=`ps aux | grep '/usr/bin/memcached -p' | grep -v 'grep' | awk '{print $2}'`

for pid in $(echo "$PIDS" ); do
    cmd="kill -9 $pid";
    echo $cmd && $cmd;
done

PIDS=`ps aux | grep '/usr/bin/memcached -p' | grep -v 'grep' | awk '{print $2}'`

if [[ -z "$PIDS" ]]; then
    echo "Bouncing memcached...";
    DIR=`dirname $0`
    cmd="$DIR/memcached-start.sh"
    echo $cmd && $cmd;
    echo "Done.";
else
    echo "Unable to kill memcached PID's."
    echo "Check to ensure you have the proper permissions"
fi
