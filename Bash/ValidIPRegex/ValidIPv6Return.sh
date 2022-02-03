#!/bin/bash
#
# Author AshDaad
# Date: 10/14/2017
#
# Returns the Valid IPv6 address from ifconfig
#

touch AshDaad-output.log
OUTPUTFILE='AshDaad-output.log'

ifconfig | grep -Po '((?=inet6).+([a-fA-F\d]{1,4}:){1,}:((25[0-5]|(2[0-4]|1{0,1}[\d]){0,1}[\d])\.){3}(25[0-5]|(2[0-4]|1{0,1}[\d]){0,1}[\d]))|((?=inet6).+((([a-fA-F\d]{1,4}:){7,7}[a-fA-F\d]{1,4})|(([a-fA-F\d]{1,4}:){1,7}:|([a-fA-F\d]{1,4}:){1,6}:[a-fA-F\d]{1,4}|([a-fA-F\d]{1,4}:){1,5}(:[a-fA-F\d]{1,4}){1,2}|([a-fA-F\d]{1,4}:){1,4}(:[a-fA-F\d]{1,4}){1,3}|([a-fA-F\d]{1,4}:){1,3}(:[a-fA-F\d]{1,4}){1,4}|([a-fA-F\d]{1,4}:){1,2}(:[a-fA-F\d]{1,4}){1,5}|[a-fA-F\d]{1,4}:((:[a-fA-F\d]{1,4}){1,6})|:((:[a-fA-F\d]{1,4}){1,7}|:))([\/%][a-zA-Z\d]{1,})?))|((?=inet6).+((([a-fA-F\d]{1,4}:?){0,4})?(?(?=(::((ffff|FFFF)(:0{1,4}){0,1}:){0,1})?))))' > "$OUTPUTFILE"

echo 'Done. Printing results from file to terminal: '$'\n'
cat "$OUTPUTFILE"

echo $'\n' " Removing output log. "
rm -v $OUTPUTFILE

