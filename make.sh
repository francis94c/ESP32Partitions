#!/bin/sh

# The pde.jar file may be buried inside the .app file on Mac OS X.
PDE=pde.jar
echo "$PDE"
javac -target 1.8 -cp "$PDE" -d bin src/ESP32Partitions.java

cd bin && zip -r ../dist/ESP32Partitions.jar * && cd ..
