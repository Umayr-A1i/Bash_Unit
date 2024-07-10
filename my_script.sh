#!/bin/bash

echo "Running automation..." > ./output_log.txt

echo "" >> ./output_log.txt
echo "Checking uptime..." >> ./output_log.txt
echo $(uptime) >> ./output_log.txt
