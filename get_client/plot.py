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
    
    print("EMPTY")
    for entry in data :
        print(entry['empty_keys']);
