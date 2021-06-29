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
