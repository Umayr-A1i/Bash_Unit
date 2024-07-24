#!/bin/bash

# Set the threshold for disk usage alert
THRESHOLD=80
LOGFILE="./file.log"

# Function to check disk usage and log a summary
check_disk_usage() {
    echo "Checking disk usage..." > $LOGFILE
    echo "--------------------------------" >> $LOGFILE
    
    # Get the disk usage using the df command and filter out unnecessary lines
    df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
    do
        # Extract the usage percentage and the device name
        usage=$(echo $output | awk '{ print $1 }' | sed 's/%//')
        partition=$(echo $output | awk '{ print $2 }')
        
        # Log the current usage
        echo "Disk Usage for $partition: $usage%" >> $LOGFILE
        
        # Check if the usage exceeds the threshold
        if [ $usage -ge $THRESHOLD ]; then
            echo "ALERT: Disk usage for $partition has reached $usage%." >> $LOGFILE
        fi
    done
    echo "--------------------------------" >> $LOGFILE
}

# Call the function to check disk usage
check_disk_usage
