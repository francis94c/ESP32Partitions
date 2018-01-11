#!/bin/bash

#
# Author: Francs Ilechukwu.
# Credits: Elochukwu Ifediora C.
#

echo ""
echo "Self Extracting ESP32 Partition Manager Installer"
echo ""

# Create Temporary Directory.
TMPDIR=`mktemp -d /tmp/self_extract.XXXXXX`

# Get Archive start point.
ARCHIVE=$(awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }' "${0}")

echo "Extracting..."
echo ""

# Extract into temporary directory.
tail -n+${ARCHIVE} "${0}" | tar zxv -C ${TMPDIR}

CDIR=`pwd`

# Go to the Temporary Directory.
cd $TMPDIR

echo ""

echo "Installing..."

# Execute Installer Script.
CScript install.vbs

# Go Back to PWD.
cd $CDIR

# Delete the Temporary Directory.
rm -rf $TMPDIR

read -n1 -r -p "Press any Key to Continue..."

# Exit Script... Anything below '__ARCHIVE_BELOW__' is gibberish and binary and
# the interpreter could really suffer from food poisining if it eats it.
exit 0

__ARCHIVE_BELOW__
