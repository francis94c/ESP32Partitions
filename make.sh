#!/bin/sh

PDE=pde.jar
echo "$PDE"
javac -target 1.8 -cp "$PDE" -d bin src/ESP32Partitions.java

cd bin && zip -r ../dist/ESP32Partitions.jar * && cd ..
