####################  Test 2 memcached_bpf (hash2) ############################
#Test 1 base bmc
echo "============================Starting test 2 : memcached_bpf (hash2)========================="
nohup ./memcached_bpf 1 &
sleep 2
./tc_memcached_attach.sh lo 

#Send requests
echo "Sending requests..."
#time ./get_client localhost 11211 ${1} ${2}

echo "[]" > results_test2.json

for ((i = 0; i < 10; i++))
do
	./get_client localhost 11211 ${1} ${2} $((${1} * i))
	pkill -10 memcached_bpf
	pkill -12 memcached_bpf
	sleep 3
	python3 analyser.py /tmp/Memcached-bpf/cache_dump.txt /tmp/Memcached-bpf/memcached_bpf_stats.txt results_test2.json
done

echo "Kill BMC"
pkill memcached_bpf
./tc_memcached_detach.sh
echo "============================End test 2 : memcached_bpf (hash2)============================="
