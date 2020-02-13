#!/bin/bash

#auto heap
limit_in_bytes=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
if [ "$limit_in_bytes" -ne "9223372036854771712" -a "$limit_in_bytes" -ne "9223372036854775807" ]
then
    limit_in_megabytes=$(expr $limit_in_bytes \/ 1048576)
    heap_size=$(expr $limit_in_megabytes \* 3 \/ 4)
    export JAVA_OPTS="-Xmx${heap_size}m $JAVA_OPTS"
    echo JAVA_OPTS=$JAVA_OPTS
fi

cd bin
nohup java $JAVA_OPTS -jar ./battery-web-0.0.1.jar &
# java $JAVA_OPTS -jar ./battery-simulator-1.0-SNAPSHOT-jar-with-dependencies.jar &

while true
do
	sleep 2
done
