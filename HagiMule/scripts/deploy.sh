#!/bin/bash

# port for SSH connection
SSH_PORT=22

# Array of hostnames/IPs to connect to
DIARY_HOSTS="acdc.enseeiht.fr"

CLIENT_HOSTS=( # salle A-204
    "aerosmith.enseeiht.fr"
    "beatles.enseeiht.fr"
    "clapton.enseeiht.fr"
    "clash.enseeiht.fr"
    "cooper.enseeiht.fr"
    "deeppurple.enseeiht.fr"
    "doors.enseeiht.fr"
    "dylan.enseeiht.fr"
    "eagles.enseeiht.fr"
    "epica.enseeiht.fr"
    "hendrix.enseeiht.fr"
)

GITLAB_REPO="https://git.inpt.fr/hervyv/hagimule.git"

USERNAME="vhy9665"

# Prompt for SSH password
read -sp "Enter SSH password for $USERNAME: " PASSWORD

# function to test connection to a host
test_connection() {
    local host=$1
    local port=$2
    nc -z -w 2 "$host" "$port" >/dev/null 2>&1 # test connection
    return $?
}

DIARY_CMD="
    TEMP_DIR=\$(mktemp -d);
    git clone $GITLAB_REPO \$TEMP_DIR;
    cd \$TEMP_DIR;
    ./script/remote_diary.sh;
"

start_diary_host() {
    # TODO
    sshpass -p "$PASSWORD" ssh "$USERNAME@$DIARY_HOSTS" -p "$SSH_PORT" "$DIARY_CMD" &
}

# commande SSH pour cloner le repo et lancer le client
CLIENT_CMD="
    TEMP_DIR=\$(mktemp -d);
    git clone $GITLAB_REPO \$TEMP_DIR;
    cd \$TEMP_DIR;
    ./script/remote_client.sh;
"

# function to start the client on a remote host
start_client() {
    local host=$1
    echo "Starting client on $host..."

    sshpass -p "$PASSWORD" ssh "$USERNAME@$host" -p "$SSH_PORT" "$CLIENT_CMD" &
}

for host in "${CLIENT_HOSTS[@]}"; do
    if test_connection "$host" "$SSH_PORT"; then
        echo "successfully connected to $host"
        start_client "$host"
    else
        echo "failed to connect to $host"
    fi
done

echo "Deployment complete. use ./scripts/client.sh to start the client."
