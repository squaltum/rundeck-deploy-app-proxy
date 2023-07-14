#!/bin/bash

#  <node name="docker02" tags="docker,02" hostname="167.172.66.5" osArch="amd64" osFamily="unix" osName="Linux" osVersion="Ubuntu-20.04" ssh-authentication="privateKey" username="robot-automation" ssh-key-storage-path="keys/project/Docker-Apps/priv-docker02.key" />
#</project>

NODEIP="$2"
NODETAG="$1"

sed -i "s/<\/project>/<node name=\"${NODETAG}\" tags=\"${NODETAG}\" hostname=\"${NODEIP}\" osArch=\"amd64\" osFamily=\"unix\" osName=\"Linux\" osVersion=\"Ubuntu-20.04\" ssh-authentication=\"privateKey\" username=\"robot-automation\" ssh-key-storage-path=\"keys\/project\/Docker-Apps\/priv.key\" \/>/g" /opt/rundeck-docker/rundeck-projects/Project1/etc/resources.xml
echo "</project>" >> /opt/rundeck-docker/rundeck-projects/Project1/etc/resources.xml

exit 0
