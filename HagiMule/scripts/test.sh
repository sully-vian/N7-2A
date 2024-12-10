#!/bin/bash

# Compile the test files
javac -d bin -cp bin:lib/* src/fr/n7/hagimule/test/*.java

if [ $? -ne 0 ]; then
    echo -e "\e[31mCompilation failed.\e[0m"
    exit 1
fi

echo -e "\e[32mCompilation successful.\e[0m"

# Run the tests
java -cp bin:lib/* org.junit.runner.JUnitCore fr.n7.hagimule.test.AllTests

if [ $? -ne 0 ]; then
    echo -e "\e[31mTests failed.\e[0m"
    exit 1
fi

echo -e "\e[32mTests successful.\e[0m"