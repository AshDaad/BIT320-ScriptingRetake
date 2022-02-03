#!/bin/bash

INTF=$(ls /sys/class/net/ | head -n 1)
FOLDERPATH="/etc/sysconfig/network-scripts/ifcfg-"
FILEPATH="${FOLDERPATH}${INTF}"
BOOTPROTO=$(grep -Po '(?<=BOOTPROTO=).+\b' $FILEPATH)
if [ grep -q -Po '(?<=DNS2=).+\b' $FILEPATH ]; then
  	DNS2=true
else
	DNS2=false
fi



function mainmenu {
    echo ""
    echo "Shell IP Config"
    echo ""
    PS3="Interface $INTF Config, what would you like to do?  "
    options=( "Set as Static" "Set as DHCP" "Restart Service" "Exit" )
    select opt in "${options[@]}"
    do
        case $opt in
			"Set as Static")
				if [ $BOOTPROTO == "dhcp" ]
				then
					sed -i "s/^BOOTPROTO=.*/BOOTPROTO=static/g" $FILEPATH
				fi
			    echo ""
				echo "Enter new IP Address: "
				read NEWIP
				if [ $BOOTPROTO == "dhcp" ]
				then
					sed -i "\$a\IPADDR=$NEWIP" $FILEPATH
				else
					sed -i "s/^IPADDR=.*/IPADDR=$NEWIP/g" $FILEPATH
				fi
				echo "Enter New Subnet Mask: "
				read NEWSM
				if [ $BOOTPROTO == "dhcp" ]
				then
					sed -i "\$a\NETMASK=$NEWSM" $FILEPATH
				else
					sed -i "s/^NETMASK=.*/NETMASK=$NEWSM/g" $FILEPATH
				fi
				echo "Enter New Gateway: "
				read NEWGW
				if [ $BOOTPROTO == "dhcp" ]
				then
					sed -i "\$a\GATEWAY=$NEWGW" $FILEPATH
				else
					sed -i "s/^GATEWAY=.*/GATEWAY=$NEWGW/g" $FILEPATH
				fi
				echo "Enter New DNS1: "
				read NEWDNS1
				if [ $BOOTPROTO == "dhcp" ]
				then
					sed -i "\$a\DNS1=$NEWDNS1" $FILEPATH
				else
					sed -i "s/^DNS1=.*/DNS1=$NEWDNS1/g" $FILEPATH
				fi
				echo "Enter New DNS2: "
				read NEWDNS2
				if [ $DNS2 = true ]; then
					sed -i "s/^DNS2=.*/DNS2=$NEWDNS2/g" $FILEPATH
				else
					sed -i "\$a\DNS2=$NEWDNS2" $FILEPATH
				fi 
				echo ""
				echo "Finished"
				echo "Returning"$'\n'
            	break
            ;;
            "Set as DHCP")
				echo "Stoping Network Services"
				#systemctl stop NetworkManager.service
			    #systemctl disable NetworkManager.service
			    sed -i 's/^BOOTPROTO=.*/BOOTPROTO=dhcp/g' $FILEPATH
				echo ""
				echo "Finished"
				echo "Returning"$'\n'
                break
            ;;
			"Restart Service")
			    echo ""
				echo "Restarting..."
				systemctl restart NetworkManager.service
				echo "Finished"$'\n'
				exit 0
			    break
			;;
			"Exit")
				exit 0
				break
			;;
            *) echo invalid option;;
        esac
    done
}

echo ""
echo "Current Interface config:"$'\n'

echo "DHCP or Static/none: "

if [ "$BOOTPROTO" == "dhcp" ]
then
	echo "Interface is using DHCP"
else
	echo "Interface is Static"$'\n'
	echo "IP Address	:	`(grep -Po '(?<=IPADDR=).+\b' $FILEPATH)`"
	echo "Subnet Mask	:	`(grep -Po '(?<=NETMASK=).+\b' $FILEPATH)`"
	echo "Gateway	:	`(grep -Po '(?<=GATEWAY=).+\b' $FILEPATH)`"
	echo "DNS1	:	`(grep -Po '(?<=DNS1=).+\b' $FILEPATH)`"

	if [ $DNS2 = true ]; then
  	echo "DNS2	:	`(grep -Po '(?<=DNS2=).+\b' $FILEPATH)`"
	fi

fi
echo ""

while true; do mainmenu; done