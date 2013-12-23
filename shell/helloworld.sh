#!/bin/sh
# test shell script

if [ $# != 1 ]; then
	echo "Usage: $0 <login user name>"
	exit 1
fi

echo "Hello ${1}!"

exit 0

