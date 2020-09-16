#!/bin/bash

# Stats generator to create a static file for the status page.

# The status page should show the following information:
# a. The date the status page was generated.
# b. The number of running processes within the container and their CPU utilisation.
# c. The memory usage within the container.
# d. the disk usage within the container.

# Step through the above steps and output them slowly to a flat file. 

# Last step make the new file live with a switcheroooney
now="$(date)"
process_count="$(ps -e | wc -l)"
memory_general="$(cat /proc/meminfo)"
memory_free="$(cat /proc/meminfo |grep -i memfree)"
disk_usage="$(df -h)"

# Write to file.
echo "<html><head><link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css\" integrity=\"sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z\" crossorigin=\"anonymous\"></head><body><h1>Status page</h1><p>Generated on: ${now}</p><p>Process count: ${process_count}</p><p>Memory: ${memory_general}</p><p>Memory free: ${memory_free}</p><p>disk_usage: ${disk_usage}</p></body></html>" > /tmp/status.html

# Swap the files around.
mv --force /tmp/status.html /usr/local/apache2/htdocs/index.html
