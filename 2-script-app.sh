#!/bin/bash

useradd robot-automation
mkdir -p /home/robot-automation/.ssh/
cat files/rundeck/public-key /home/robot-automation/.ssh/authorized_keys
chmod 400 /home/robot-automation/.ssh/authorized_keys
chown -R robot-automation:robot-automation /home/robot-automation/.ssh

cp -r files/docker-apps/nginx /opt/

while read line
do
	DOCKERVAR=$( echo ${line} |gawk -F"=" '{ print $1 }' )
	if [ ${DOCKERVAR} = "DOCKERURL" ];
	then
		DOCKERVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
		sed -i "s/DOCKERURL/${DOCKERVAR}/g" /opt/nginx/config/nginx.conf
		#echo ${DOCKERVAR}
	fi
done < VARS

cd /opt/nginx/
docker-compose up -d
