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
