#!/bin/bash

useradd robot-automation
mkdir -p /home/robot-automation/.ssh/
cat files/rundeck/public-key > /home/robot-automation/.ssh/authorized_keys
chmod 400 /home/robot-automation/.ssh/authorized_keys
chown -R robot-automation:robot-automation /home/robot-automation/.ssh
echo "PubkeyAcceptedKeyTypes +ssh-rsa" >> /etc/ssh/sshd_config
systemctl restart ssh

cp -r files/docker-apps/nginx /opt/
mkdir -p /opt/nginx/config/extra
chown -R robot-automation /opt/nginx/config/extra

while read line
do
	DOCKERVAR=$( echo ${line} |gawk -F"=" '{ print $1 }' )
	if [ "${DOCKERVAR}" = "DOCKERURL" ];
	then
		DOCKERVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
		sed -i "s/DOCKERURL/${DOCKERVAR}/g" /opt/nginx/config/nginx.conf
		#echo ${DOCKERVAR}
	fi
done < VARS

cd /opt/nginx/
docker-compose up -d

exit 0
