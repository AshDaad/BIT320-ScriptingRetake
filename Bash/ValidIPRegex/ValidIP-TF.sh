#!/bin/bash
#
#
# Test a valid IP address and return a Ture/False output
#

# \b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b
#
# Only valid IPv4 Addresses:
# (25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)
#
# Grep only valid IPv4 Addresses from a file:
# grep -E -o "(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?))" file.txt

regexIP='(?:(25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(?:(25[0-5]|2[0-4]\d|[01]?\d\d?))'
INPUTFILE='iplist.txt'

cat $INPUTFILE | while read LINE
do
    if [[ $LINE =~ $regexIP ]]
    then
        echo " $LINE - Valid "$'\r'
    else
        echo " $LINE - Invalid "$'\r'
    fi
done
