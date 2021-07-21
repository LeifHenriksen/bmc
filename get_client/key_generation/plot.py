import json
import sys
import matplotlib.pyplot as plt

if __name__ == "__main__" :
    if len(sys.argv) < 2 :
        print("To few arguments.\nFormat : plot.py json_file");
        exit(0);

    data = json.load(open(sys.argv[1]));
    print(len(data))
    hot_keys   = []
    warm_keys  = []
    mild_keys  = []
    cold_keys  = []
    requetes   = []
    
    i = 1000000;
    for entry in data :
        hot_keys.append(entry['hot_keys'])
        warm_keys.append(entry['warm_keys'])
        mild_keys.append(entry['mild_keys'])
        cold_keys.append(entry['cold_keys'])
        requetes.append(i)
        i = i + 1000000

    
    plt.plot(requetes, hot_keys, label = "HOT")
    plt.plot(requetes, warm_keys, label = "WARM")
    plt.plot(requetes, mild_keys, label = "MILD")
    plt.plot(requetes, cold_keys, label = "COLD")
    plt.xlabel('Requetes')
    plt.ylabel('NB d\'entrees')
    plt.legend()
    plt.savefig(sys.argv[1] + ".svg", format="svg")
    plt.show()

