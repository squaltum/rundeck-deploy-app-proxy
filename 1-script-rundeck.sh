#!/bin/bash

cp -rp rundeck-docker /opt/
chown -R 1000 /opt/rundeck-docker/rundeck-plugins

while read line
do
	RUNDECKVAR=$( echo ${line} |gawk -F"=" '{ print $1 }' )
	if [ "${RUNDECKVAR}" = "RUNDECKURL" ]; 
	then
		RUNDECKVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
		sed -i "s/RUNDECKURL/${RUNDECKVAR}/g" /opt/rundeck-docker/mysql/docker-compose.yml
		sed -i "s/RUNDECKURL/${RUNDECKVAR}/g" /opt/rundeck-docker/nginx-config/rundeck.conf
		#echo ${RUNDECKVAR}
	fi
done < VARS

cd /opt/rundeck-docker/mysql/
docker-compose up -d

exit 0
