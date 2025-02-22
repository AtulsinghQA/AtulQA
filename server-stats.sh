#!/bin/bash

# Function to get total CPU usage
get_cpu_usage() {
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}'
    echo "---------------------------------"
}

# Function to get memory usage
get_memory_usage() {
    echo "Memory Usage:"
    free -m | awk 'NR==2{printf "Used: %sMB, Free: %sMB, Total: %sMB, Usage: %.2f%%\n", $3, $4, $2, $3*100/$2 }'
    echo "---------------------------------"
}

# Function to get disk usage
get_disk_usage() {
    echo "Disk Usage:"
    df -h --total | awk 'END{printf "Used: %s, Free: %s, Total: %s, Usage: %s\n", $3, $4, $2, $5}'
    echo "---------------------------------"
}

# Function to get top 5 processes by CPU usage
get_top_cpu_processes() {
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -6
    echo "---------------------------------"
}

# Function to get top 5 processes by memory usage
get_top_memory_processes() {
    echo "Top 5 Processes by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -6
    echo "---------------------------------"
}

# Function to get additional system information
get_system_info() {
    echo "System Information:"
    echo "OS Version: $(lsb_release -d | cut -f2-)"
    echo "Uptime: $(uptime -p)"
    echo "Load Average: $(uptime | awk -F 'load average:' '{print $2}')"
    echo "Logged-in Users: $(who | wc -l)"
    echo "Failed Login Attempts: $(grep "Failed password" /var/log/auth.log | wc -l 2>/dev/null || echo "Log file not accessible")"
    echo "---------------------------------"
}

# Run all functions
get_cpu_usage
get_memory_usage
get_disk_usage
get_top_cpu_processes
get_top_memory_processes
get_system_info

