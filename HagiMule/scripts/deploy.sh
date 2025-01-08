#!/bin/bash

# Default port for SSh connections
DEFAULT_PORT=22

# Default port for HagiMule
DEFAULT_HAGIMULE_PORT=9665

# Array of hostnames/IPs to connect to
HOSTS=(
    ...
)

# function to test connection to a host
test_connection() {
    local host=$1
    local port=$2
    nc -z -w 2 "$host" "$port" > /dev/null 2>&1 # test connection
    return $?
}

# function to start the client on a remote host
start_client() {
    local host=$1
    echo "Starting client on $host..."
}