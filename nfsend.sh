#!/bin/sh
cat /var/log/pixlog | ./nfsend.pl 2> /dev/null &
