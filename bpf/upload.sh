#!/bin/bash
LIP6_GATEWAY="gate.lip6.fr"
LIP6_LOGIN="henriksen"
BMC="bmc/bmc bmc/bmc_kern.ll bmc/bmc_kern.o"
MEMCACHED_BPF="bmc-challenger/memcached_bpf bmc-challenger/memcached_bpf_kern.o bmc-challenger/memcached_bpf_kern.ll"
BMC_GATE="bmc*"
MEMCACHED_BPF_GATE="memcached*"
BMC_LOGIN="leif"
BMC_IP="132.227.76.13"

if scp -r ${BMC} ${MEMCACHED_BPF} ${LIP6_LOGIN}@${LIP6_GATEWAY}:~/ ; then
    ssh ${LIP6_LOGIN}@${LIP6_GATEWAY} "scp -r ${BMC_GATE} ${MEMCACHED_BPF_GATE} ${BMC_LOGIN}@${BMC_IP}:~/"
else
    echo "scp failed"
    exit 1;
fi 
