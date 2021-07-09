####################  Test 2 memcached_bpf (hash2) ############################
echo "=======================Starting test 2 : memcached_bpf (hash2)===================="
timestamp=$(date "+%Y-%m-%d-%H-%M-%S")
HP=${3}
count=10
results=res_KEYCNT${2}_REQ$((${1} * ${count}))_HP${HP}_${timestamp}.json

nohup ./memcached_bpf 1 &
sleep 2
./tc_memcached_attach.sh lo 

#Send requests
echo "Sending requests..."
#time ./get_client localhost 11211 ${1} ${2}

echo "[]" > ${results}

for ((i = 0; i < ${count}; i++))
do
	./get_client localhost 11211 ${1} ${2} $((${1} * i))
	pkill -10 memcached_bpf
	pkill -12 memcached_bpf
	sleep 3
	python3 analyser.py /tmp/Memcached-bpf/cache_dump.txt /tmp/Memcached-bpf/memcached_bpf_stats.txt ${results}
done

echo "Kill BMC"
pkill memcached_bpf
./tc_memcached_detach.sh
echo "=======================End test 2 : memcached_bpf (hash2)======================="
