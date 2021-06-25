#!/bin/bash
LIP6_GATEWAY="gate.lip6.fr"
LIP6_LOGIN="henriksen"
BMC="get_client"
BMC_LOGIN="leif"
BMC_IP="132.227.76.13"

if scp -r ${BMC} ${LIP6_LOGIN}@${LIP6_GATEWAY}:~/ ; then
    ssh ${LIP6_LOGIN}@${LIP6_GATEWAY} "scp -r ${BMC} ${BMC_LOGIN}@${BMC_IP}:~/"
else
    echo "scp failed"
    exit 1;
fi 
