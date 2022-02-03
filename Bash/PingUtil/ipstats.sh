#!/bin/bash
#
# Tests a list of IPs from a file and outputs to a file if they are
# reachable or not, as well as a time stamp.
#
# Author: AshDaad
# Date: 10/9/2017
#
#
# example output: 
# [Timestamp] [IP Address] Status: [Reachable/Unreachable]

INPUTFILE='iplist.txt'
touch pingtest.log
OUTPUTFILE='pingtest.log'

function Ping()
{
        echo "IP Ping Tests -- `date`"$'\r' >> $OUTPUTFILE

        while read LINE
        do
                ip="$LINE"
                ping -c2 $ip > /dev/null # the -c makes the ping fire twice
                                        # the '> /dev/null' hides the command output
                if [[ $? -eq 0 ]]
                then
                        echo "`date` - $ip - Status: Reachable"$'\r' >> $OUTPUTFILE
                else
                        echo "`date` - $ip - Status: Unreachable"$'\r' >> $OUTPUTFILE
                fi
        #done
        done < "$INPUTFILE" # needed to pass file back into the loop
}

while :
do
	Ping
	sleep 30
done