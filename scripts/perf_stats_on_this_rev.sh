#!/bin/bash
set -e

rev=`git log -1 --pretty='format:%h' HEAD`
time=`rspec $1 | grep 'RUNTIME: ' | cut -d ' ' -f 2`
echo $rev,$time
