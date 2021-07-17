#!/bin/bash

[ $(whoami) = root ] || exec sudo $0 

nvme0=$(nvme smart-log /dev/nvme0n1 | grep "Temperature Sensor" | sed 's/Temperature Sensor/temp/g;s/:/=/;s/ C//;s/[[:space:]]//g')
ts=$(($(date +%s)*1000000000))

tempdata='temp,host=workstation,name=nvme0n1 '$(echo $nvme0 | sed 's/[[:space:]]/,/g')' '$ts
echo $tempdata
