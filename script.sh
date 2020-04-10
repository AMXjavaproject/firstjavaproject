#!/bin/bash

echo "creating a folder with current timestamp under release directory"
time_stamp=`date +%y%m%d%H%M%S`
mkdir -p  release/$time_stamp
cp $1 release/$time_stamp
git add .
git commit -m "added new jar file under folder $time_stamp"
git push
