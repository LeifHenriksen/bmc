import json
import sys
import matplotlib.pyplot as plt

if __name__ == "__main__" :
    if len(sys.argv) < 2 :
        print("To few arguments.\nFormat : plot.py json_file");
        exit(0);

    data = json.load(open(sys.argv[1]));
    hot_keys   = []
    warm_keys  = []
    mild_keys  = []
    cold_keys  = []
    empty_keys = []
    HIT        = []
    requetes   = []
    
    i = 10000000;
    for entry in data[1:] :
        hot_keys.append(entry['hot_keys'])
        warm_keys.append(entry['warm_keys'])
        mild_keys.append(entry['mild_keys'])
        cold_keys.append(entry['cold_keys'])
        empty_keys.append(entry['empty_keys'])
        requetes.append(i)
        i = i + 10000000

    last_hit = data[1]['hit_count'] 
    HIT.append(last_hit)
    for entry in data[2:]:
        HIT.append((int(entry['hit_count']) - int(last_hit)))
        last_hit = entry['hit_count']
    
    for j in range(len(HIT)) :
        hit_percent = 1 - ((10000000 / int(HIT[j])) - 1)
        HIT[j] = hit_percent

    fig, ax1 = plt.subplots()
    
    ax1.plot(requetes, hot_keys, label = "HOT")
    ax1.plot(requetes, warm_keys, label = "WARM")
    ax1.plot(requetes, mild_keys, label = "MILD")
    ax1.plot(requetes, cold_keys, label = "COLD")
    ax1.plot(requetes, empty_keys, label = "EMPTY")
    ax1.set_xlabel('Requetes')
    ax1.set_ylabel('NB d\'entrees')
    ax1.legend()

    ax2 = ax1.twinx()
    ax2.plot(requetes, HIT, label = "HIT", color = "CYAN")
    ax2.legend()
    ax2.set_ylabel('Taux de HIT')
    
    fig.tight_layout()
    plt.savefig(sys.argv[1] + ".svg", format="svg")
    plt.show()

