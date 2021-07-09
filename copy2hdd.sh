#!/bin/bash

#check if not already running
if ps -ef | grep -v grep | grep "mv /mnt/" ; then
    echo "already running" && exit 0
fi
##check which disk is free
##target=$(df /mnt/hdd? | tail -n +2 | sort -nk 4 | tail -1 | head -n1 | awk '{print $6;}')
#df=$(df -h /mnt/hdd? | tail -n +2 | sort -hk 4 | tail -1)
#target=$(echo $df | awk '{print($6)}')
#avl=$(echo $df | awk '{print($4)}')
target=$(echo "/mnt/hdd"$(($RANDOM % 10))"/")
echo "target disk: ${target}, available: ${avl}"

if [ `ls -A /mnt/md3/plots/ | wc -l` == "0" ]; then
      echo "md3/plots is empty"
  else
      delete=$(ls $target/plot-k32-* | head -1)
      echo "deleting file ${delete}"
      rm $delete
      copy=$(ls /mnt/md3/plots/ | head -1)
      echo "copy file ${copy} to ${target}/pool/"
      mv /mnt/md3/plots/$copy $target/pool/
fi

if [ `ls -A /mnt/md4/plots/ | wc -l` == "0" ]; then
      echo "md4/plots is empty"
  else
      delete=$(ls $target/plot-k32-* | head -1)
      echo "deleting file ${delete}"
      rm $delete
      copy=$(ls /mnt/md4/plots/ | head -1)
      echo "copy file ${copy} to ${target}/pool/"
      mv /mnt/md4/plots/$copy $target/pool/
fi

if [ `ls -A /mnt/md2/plots/ | wc -l` == "0" ]; then
      echo "md2/plots is empty"
  else
      delete=$(ls $target/plot-k32-* | head -1)
      echo "deleting file ${delete}"
      rm $delete
      copy=$(ls /mnt/md2/plots/ | head -1)
      echo "copy file ${copy} to ${target}/pool/"
      mv /mnt/md2/plots/$copy $target/pool/
fi

echo 'copy completed'
