#!/bin/sh
if [ ${1} -eq 0 ] || [ ${2} -eq 0 ] 
  then
    echo "No arguments supplied"
    exit 1
fi
####################  Test 1 base bmc ############################
echo "================================Starting test 1 : base bmc========================================"
nohup ./bmc 1 &
sleep 2
./scripts/tc_attach.sh lo 

#Send requests
echo "Sending requests..."
time ./get_client localhost 11211 ${1} ${2}

#Get stats
echo "Get stats"
pkill -10 bmc
pkill bmc
./scripts/tc_detach.sh
#cat /sys/kernel/debug/tracing/trace_pipe &
#pkill cat
cat /tmp/bmc_stats.txt
echo "================================End test 1 : base bmc    =========================================="

####################  Test 2 memcached_bpf (hash2) ############################
#Test 1 base bmc
echo "============================Starting test 2 : memcached_bpf (hash2)================================"
nohup ./memcached_bpf 1 &
sleep 2
./tc_memcached_attach.sh lo 

#Send requests
echo "Sending requests..."
time ./get_client localhost 11211 ${1} ${2}


#Get stats
echo "Get stats"
pkill -10 memcached_bpf
pkill memcached_bpf
./tc_memcached_detach.sh
#cat /sys/kernel/debug/tracing/trace_pipe &
#pkill cat
cat /tmp/Memcached-bpf/*
echo "============================End test 2 : memcached_bpf (hash2)    ================================"

####################  Test 3 bmc2 ############################
echo "================================Starting test 3 : bmc2 ========================================"
nohup ./bmc2 1 &
sleep 2
./scripts/tc_attach.sh lo 

#Send requests
echo "Sending requests..."
time ./get_client localhost 11211 ${1} ${2}

#Get stats
echo "Get stats"
pkill -10 bmc2
pkill bmc2
./scripts/tc_detach.sh
#cat /sys/kernel/debug/tracing/trace_pipe &
#pkill cat
cat /tmp/bmc2_stats.txt
echo "================================End test 3 : base bmc    =========================================="


