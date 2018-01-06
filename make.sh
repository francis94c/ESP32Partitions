#!/bin/sh

PDE=pde.jar

echo "PDE Jar:->$PDE"

echo "Checking and Making Directories"

if [ ! -d dist/ESP32Partitions/tool ]; then
  mkdir -p dist/ESP32Partitions/tool;
fi

if [ ! -d jar ]; then
  mkdir -p jar;
fi

if [ ! -d bin ]; then
  mkdir -p bin;
fi

echo "Done Checking and Making Directories"

javac -target 1.8 -cp "$PDE" -d bin src/ESP32Partitions.java

echo "Creating Jar..."

cd bin && zip -r ../jar/ESP32Partitions.jar * && cd ..

cp jar/ESP32Partitions.jar dist/ESP32Partitions/tool/ESP32Partitions.jar

echo "Getting the latest python script..."

cp ../../esp-partition.py dist/ESP32Partitions/tool/esp-partition.py

echo "Packaging Distribution..."

cd dist && zip -r ESP32Partitions.zip * && cd ..

echo "Cleaning Up..."

rm -r bin/com

echo "Done"
