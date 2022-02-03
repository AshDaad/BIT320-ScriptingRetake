#!/bin/bash

find "`pwd`/" -type f -exec md5sum '{}' ';' | sort | uniq --all-repeated=separate --check-chars 33 | cut -c 35-


PS3='Would you like to delete all duplicated and keep first original?'
options=("Yes" "No")
select opt in "${options[@]}"
do
        case $opt in
                "No")
                        exit 0
                break
				;;
                "Yes")
						echo "Removing..."
						find "`pwd`/" -type f -exec md5sum '{}' ';' | sort | awk 'BEGIN{lasthash = ""} $1 == lasthash {print $2} {lasthash = $1}' | xargs rm
				break
				;;
		esac
done
