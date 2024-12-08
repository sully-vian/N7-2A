#!/bin/sh

# Compile the java source files to the bin directory
javac -d bin $(find src -name "*.java")

echo "Build completed."