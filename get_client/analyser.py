import json
import sys

results_file = ""
results      = {} 

def get_key(entry) :
    return entry['data'][6 : 23];

def is_hot(key) :
    min_hot = "1500000ABCDEFGHI";
    return key < min_hot;

def analyse_json_dump(cache) :
    hot       = 0;
    empty     = 0;
    entry_nb  = 0;
    normal_nb = 0;

    for entry in cache :
        entry_nb = entry_nb + 1;
        if entry['valid'] > 0 :
            if is_hot(get_key(entry)) :
                hot = hot + 1;
        else :
            empty = empty + 1;
    
    normal = entry_nb - hot - empty;

    results["hot_keys"] = hot;
    results["empty_keys"] = empty;
    results["normal_keys"] = normal;
    print("Cache  size :", entry_nb);
    print("HOT    keys :", hot);
    print("EMPTY  keys :", empty);
    print("NORMAL keys :", normal);
    print("SUM == size :", (entry_nb - normal - hot - empty) == 0);

def analyse_stats(stats) :
    lines = stats.readlines();
    get_recv_count = lines[0].split(" ");
    set_recv_count = lines[1].split(" ");
    get_resp_count = lines[2].split(" ");
    get_key_count  = lines[3].split(" ");
    hit_count      = lines[4].split(" ");
    miss_count     = lines[5].split(" ");
    update_count   = lines[6].split(" ");
    kill_count     = lines[10].split(" ");
    
    for stat in lines :
        line = stat.split(" ");
        print(line[1], line[2][:-1]);
        results[line[1]] = line[2][:-1];

if __name__ == "__main__":
    if len(sys.argv) < 4 :
        print("To few arguments.\nFormat : analyser.py json_file stats_file results_file");
        exit(0);
    
    print("JSON file : " + sys.argv[1]);
    json_dump = open(sys.argv[1]);
    data = json.load(json_dump);
    analyse_json_dump(data['cache']);

    print("Stats file : " + sys.argv[2]);
    stats = open(sys.argv[2]);
    analyse_stats(stats);

    stats.close();
    json_dump.close();

    results_file = open(sys.argv[3], "r");
    data = json.load(results_file);
    data.append(results);
    results_file.close()

    results_file = open(sys.argv[3], "w");
    results_file.write(json.dumps(data));
    results_file.close();
