#!/bin/sh

####################  Test 1 base bmc ############################
echo "================================Starting test 1 : base bmc========================================"
nohup ./bmc 1 &
sleep 2
./scripts/tc_attach.sh lo 

#Send requests
echo "Sending requests..."
./get_client localhost 11211

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
./get_client localhost 11211

#Get stats
echo "Get stats"
pkill -10 memcached_bpf
pkill memcached_bpf
./tc_memcached_detach.sh
#cat /sys/kernel/debug/tracing/trace_pipe &
#pkill cat
cat /tmp/Memcached-bpf/*
echo "============================End test 2 : memcached_bpf (hash2)    ================================"

