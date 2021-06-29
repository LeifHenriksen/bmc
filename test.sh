#!/bin/sh
if [ ${1} -eq 0 ] || [ ${2} -eq 0 ] 
  then
    echo "No arguments supplied"
    exit 1
fi
./test1.sh ${1} ${2}
./test2.sh ${1} ${2}
./test3.sh ${1} ${2}

