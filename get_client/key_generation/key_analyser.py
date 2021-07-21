import json
import sys

results = [] 

HOT  = 0;
WARM = 1;
MILD = 2;
COLD = 3;
def get_temperature(key) :
    max_hot  = 1500000;
    max_warm = 4500000;
    max_mild = 13500000;
    key = int(key.split('A')[0]); 
    if key < max_hot :
        return HOT;
    elif key < max_warm :
        return WARM;
    elif key < max_mild :
        return MILD;
    else :
        return COLD;

def analyse_keys(keys) :
    temps     = [0,0,0,0];
    entry_nb  = 0;

    i = 0
    for entry in keys :
        entry_nb = entry_nb + 1;
        temp = get_temperature(entry);
        temps[temp] = temps[temp] + 1;
        i = i + 1
        
        if (i % 1000000) == 0 :
           result = {}
           result["hot_keys"] = temps[HOT];
           result["warm_keys"] = temps[WARM];
           result["mild_keys"] = temps[MILD];
           result["cold_keys"] = temps[COLD];
           temps[HOT]  = 0
           temps[WARM] = 0
           temps[MILD] = 0
           temps[COLD] = 0
           results.append(result)
    
    print("Cache  size :", entry_nb);
    print("HOT    keys :", temps[HOT]);
    print("WARM   keys :", temps[WARM]);
    print("MILD   keys :", temps[MILD]);
    print("COLD   keys :", temps[COLD]);
    print("SUM == size :", (entry_nb - temps[HOT] - temps[WARM] - temps[MILD] - temps[COLD]) == 0);

if __name__ == "__main__":
    if len(sys.argv) < 3 :
        print("To few arguments.\nFormat : key_analyser.py json_file results_file");
        exit(0);
    
    keys = open(sys.argv[1])
    analyse_keys(keys)
    keys.close()

    results_file = open(sys.argv[2], "w");
    results_file.write(json.dumps(results));
    results_file.close();
