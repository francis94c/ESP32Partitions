#!/bin/sh

#
# Author: Francis Ilechukwu.
# Credits: Elochukwu Ifediora C.
#
# This File is responsible for all compilations and generation of distributions.
# This will shell script will output the following
# 1) An Archive containg the folder and structure to extract to your Arduino IDE
# Tools Directory of you wish to install manually.
# 2) And a setup.sh file for easy/automatic installation.
#

# Location of pde.jar, the jar which contains the Editor ant Tools classes.
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

echo "Cleaning Up Stage 1..."

if [ -f dist/setup.sh ]; then
  rm dist/setup.sh
fi

echo "Done Checking and Making Directories"

# Compiling Java Program
javac -target 1.8 -cp "$PDE" -d bin src/ESP32Partitions.java

echo "Creating Jar..."

cd bin && zip -r ../jar/ESP32Partitions.jar * && cd ..

# Copy the Jar File to the tools folder to assume a folder structure expected in
# the Arduino IDE Tools folder.
cp jar/ESP32Partitions.jar dist/ESP32Partitions/tool/ESP32Partitions.jar

echo "Getting the latest python script..."

# Since this repo is a submodule of the repo esp-partition-gui, the main python
# file should be soe levels above the current directory.
cp ../../esp-partition.py dist/ESP32Partitions/tool/esp-partition.py

# Time to Packup and Clean...
echo "Packaging Distribution..."

cd dist && zip -r ESP32Partitions.zip * && cd ..

echo "Cleaning Up Stage 2..."

rm -r bin/com
rm jar/ESP32Partitions.jar

# Copy the install.vbs script that will actually do the installation on the
# target machine into our payload folder. VBScript was used for this to counter
# elevation issues.
cp install.vbs dist/ESP32Partitions/install.vbs

# Create a tar file from the payload folder.
cd dist/ESP32Partitions && tar -zcf binaries.tar * && cd ../..

# Copy out a template decompress.sh file that will be the executble part of our
# setup script into the dist folder.
cp decompress.sh dist/setup.sh && cd dist/ESP32Partitions

# Decompress and pour the output into our setup script.
cat binaries.tar >> ../setup.sh && cd ../..

echo "Cleaning Up Stage 3..."

rm -r dist/ESP32Partitions

echo "Done"

read -n1 -r -p "Press any Key to Continue..."
