#!/bin/bash

# Compile the test files
javac -d bin -cp bin:lib/* $(find src -name "*.java")

echo "Test compilation completed."

# Run the tests
java -cp bin:lib/* org.junit.runner.JUnitCore fr.n7.hagimule.test.AllTests

echo "Tests completed."