#!/bin/bash

cp -r files/docker-apps/nginx /opt/

while read line
do
	DOCKERVAR=$( echo ${line} |gawk -F"=" '{ print $1 }' )
	if [[ ${DOCKERVAR} == "DOCKERURL" ]];
	then
		DOCKERVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
		sed -i "s/DOCKERURL/${DOCKERVAR}/g" /opt/nginx/config/nginx.conf
		#echo ${DOCKERVAR}
	fi
done < VARS

cd /opt/nginx/
docker-compose up -d
