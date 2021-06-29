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


