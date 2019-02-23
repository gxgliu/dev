#!/bin/sh

echo "This shell script is to build the C source codes"

cd ../C
make clean; make

if [ $? != 0 ]; then
	exit 1
fi

exit 0
