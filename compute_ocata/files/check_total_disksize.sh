#!/bin/sh
filesystem=$1
expectedsize=$2

actualsize=`df -hP $filesystem | grep -v Filesystem | awk '{print $2}'`
echo "Actual size: $actualsize; Expected size: $expectedsize"
if [ "$expectedsize" = "$actualsize" ]
then
  exit 0
else
  exit 2
fi


