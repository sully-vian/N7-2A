#!/bin/bash

# Compile the java source files to the bin directory
javac -d bin $(find src -name "*.java")

if [ $? -ne 0 ]; then
    echo -e "\e[31mBuild failed.\e[0m"
    exit 1
fi

echo -e "\e[32mBuild successful.\e[0m"
