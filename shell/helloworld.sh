#!/bin/sh
# test shell script
# Usage: $0 $USER

if [ $# != 1 ]; then
	echo "Usage: $0 <login user name>"
	exit 1
fi

echo "Hello $USER !"

exit 0

