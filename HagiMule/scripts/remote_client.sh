#!/bin/bash

DATA_URL="https://sully-vian.github.io"

mkdir -p "storage/uploads"

# curl with -s flag to suppress progress meter
curl -so "storage/uploads/home.html" "$DATA_URL"

./scripts/build.sh

./scripts/client.sh
