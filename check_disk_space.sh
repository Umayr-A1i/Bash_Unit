#!/bin/bash

# Set the threshold for disk usage alert
THRESHOLD=80

# Function to check disk usage and print a summary
check_disk_usage() {
    echo "Checking disk usage..."
    echo "--------------------------------"
    
    # Get the disk usage using the df command and filter out unnecessary lines
    df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
    do
        # Extract the usage percentage and the device name
        usage=$(echo $output | awk '{ print $1 }' | sed 's/%//')
        partition=$(echo $output | awk '{ print $2 }')
        
        # Print the current usage
        echo "Disk Usage for $partition: $usage%"
        
        # Check if the usage exceeds the threshold
        if [ $usage -ge $THRESHOLD ]; then
            echo "ALERT: Disk usage for $partition has reached $usage% which is above the threshold of $THRESHOLD%!"
        fi
    done
    
    echo "--------------------------------"
    echo "Disk usage check complete."
}

# Call the function to check disk usage
check_disk_usage
