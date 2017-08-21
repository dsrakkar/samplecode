#!/bin/bash
OPENSTACK_PROJECT_RC=$(find ${HOME} -path ${HOME}/SSI\ Network\ Root -prune -o -type f -name admin-openrc.sh -print)

if [ -n ${OPENSTACK_PROJECT_RC} ]
then
echo "Found admin-openrc.sh in users home"
echo "source ${OPENSTACK_PROJECT_RC}"
source "${OPENSTACK_PROJECT_RC}"
#read OPENSTACK_PROJECT_RC
#source "${OPENSTACK_PROJECT_RC}"
else
echo "Could not find admin-openrc.sh in ${HOME}"
echo "Please set admin-openrc.sh OPENSTACK_PROJECT_RC: /path/to/project/project_rc_file"
read OPENSTACK_PROJECT_RC
source "${OPENSTACK_PROJECT_RC}"
fi
if [ $# -lt 1 ]
then
echo "Usage: $0 INSTANCE_NAME"
exit 1
fi

INSTANCE_NAME=$1
echo ${INSTANCE_NAME}
INSTANCE_ID=$(openstack server list --all-projects | grep -i ${INSTANCE_NAME} | awk '{print $2}')
echo ${INSTANCE_ID}
LEN=$(echo $INSTANCE_ID | wc -c)
if [ $LEN == 37 ] ; then
openstack server show ${INSTANCE_ID}
else   echo "wrong instance name" ; exit
fi
