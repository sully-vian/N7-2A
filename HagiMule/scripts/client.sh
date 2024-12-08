#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [0|1]"
    exit 1
fi

# Lancer le client avec le paramètre passé en argument
java -cp bin fr.n7.hagimule.client.Client "$1"