#!/bin/bash

while read line
do
	RUNDECKVAR=$( echo ${line} |gawk -F"=" '{ print $1 }' )
	if [[ ${RUNDECKVAR} == "RUNDECKURL" ]];
	then
		RUNDECKVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
		sed -i "s/RUNDECKURL/${RUNDECKVAR}/g" rundeck-docker/mysql/docker-compose.yml
		sed -i "s/RUNDECKURL/${RUNDECKVAR}/g" rundeck-docker/nginx-config/rundeck.conf
		#echo ${RUNDECKVAR}
	fi
done < VARS 


#cp -rp rundeck-docker /opt/

