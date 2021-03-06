import json
import sys

if __name__ == "__main__" :
    if len(sys.argv) < 2 :
        print("To few arguments.\nFormat : plot.py json_file");
        exit(0);

    data = json.load(open(sys.argv[1]));
    
    print("HOT")
    for entry in data :
        print(entry['hot_keys']);
    
    print("WARM")
    for entry in data :
        print(entry['warm_keys']);
    
    print("MILD")
    for entry in data :
        print(entry['mild_keys']);
    
    print("COLD")
    for entry in data :
        print(entry['cold_keys']);
    
    print("EMPTY")
    for entry in data :
        print(entry['empty_keys']);
   
    print("HITS")
    print(data[0]['hit_count'])
    last_hit = data[0]['hit_count']
    for entry in data[1:]:
        print(int(entry['hit_count']) - int(last_hit));
        last_hit = entry['hit_count']
