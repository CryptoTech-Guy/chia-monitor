#!/bin/bash

cd /home/chia-blockchain/
. ./activate

export HOME=/home
export PATH=$PATH':/home'

readarray -t arr <<<$(/home/chia-blockchain/venv/bin/chia farm summary)
unset -v 'arr[5]'
unset -v 'arr[6]'
Expectedtimetowin=$(echo ${arr[10]} | cut -d' ' -f 5)
arr[10]=$(echo 'Expectedtimetowin='$(($Expectedtimetowin+1)))
unset -v 'arr[11]'

for i in ${!arr[@]}; do
	data=$(echo $data','${arr[$i]} | sed 's/:/=/;s/ C//;s/[[:space:]]//g')
done;

ts=$(($(date +%s)*1000000000))
chiadata='chia,host=workstation,name=farm '$data' '$ts
chiadata=$(echo $chiadata | sed 's/,Farmingstatus/Farmingstatus/;s/Farming,/1,/;s/TiB//g;s/PiB//g;s/EiB//g')

deactivate

echo $chiadata

