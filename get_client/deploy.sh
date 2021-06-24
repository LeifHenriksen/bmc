#!/bin/bash
LIP6_GATEWAY="gate.lip6.fr"
LIP6_LOGIN="pires"
BMC="${1}"
BMC_LOGIN="baptiste"
BMC_IP="132.227.76.13"

if scp -r ${BMC} ${LIP6_LOGIN}@${LIP6_GATEWAY}:~/ ; then
    ssh ${LIP6_LOGIN}@${LIP6_GATEWAY} "scp -r ${1} ${BMC_LOGIN}@${BMC_IP}:~/"
else
    echo "scp failed"
    exit 1;
fi