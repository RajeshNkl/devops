#!/bin/bash

mem_check () {
    MEM_TOTAL=$(awk '/^MemTotal/ {print $2}' /proc/meminfo)
    MEM_FREE=$(awk '/^MemFree/ {print $2}' /proc/meminfo)
    echo $((MEM_FREE * 100 / MEM_TOTAL))  # Output the percentage
}

PERC=$(mem_check)  # Capture the output of the function

if [ "$PERC" -le 25 ]; then
    echo "Memory is critical"
    sync; echo 3 > /proc/sys/vm/drop_caches
else
    echo "Memory is OK"
fi
