#!/bin/bash

mem_check () {
                 MEM_TOTAL=`grep "^MemTotal" /proc/meminfo|awk '{print $2}'`
                 MEM_FREE=`grep "^MemFree" /proc/meminfo|awk '{print $2}'`
                 PERC=$((${MEM_FREE}*100/${MEM_TOTAL}))
                 return $PERC
             }
mem_check
if [ $PERC -le 30 ]; then
   echo "Memory is critical"
   sync; echo 3 > /proc/sys/vm/drop_caches
else
   echo " Memory is OK"
fi
