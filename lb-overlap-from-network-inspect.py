import json
import sys
# This script processes output from the following docker commands
# docker network inspect -v $(docker network ls -f driver=overlay -q) > /tmp/network-inspect.json

def main():
    network_file="network-inspect.json"
    if len(sys.argv) >= 2:
        network_file=sys.argv[1]
    with open(network_file) as f:
        networks = json.load(f)
        ips = container_ips(networks)
        dupes = list_duplicates(ips)

        print("Found {} ips".format(len(ips)))
        print("Found {} blank ips".format(len([x for x in ips if x == ''])))
        print(dupes)


def container_ips(networks):
    ips = []
    for network in networks:
        if not network['Containers']:
            continue
        for container in network['Containers']:
            ips.append(network['Containers'][container]['IPv4Address'])
    return ips


def list_duplicates(seq):
    seen = set()
    seen_add = seen.add
    # adds all elements it doesn't know yet to seen and all other to seen_twice
    seen_twice = set(x for x in seq if x in seen or seen_add(x))
    # turn the set into a list (as requested)
    return list(seen_twice)


if __name__ == '__main__':
    main()
