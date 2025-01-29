#!/bin/bash

ARCHIVE_NAME="projet-graphes.tar.gz"

tar -czf "../$ARCHIVE_NAME" data/ doc/ video/ main.py res.txt

echo "Created archive: ../$ARCHIVE_NAME"