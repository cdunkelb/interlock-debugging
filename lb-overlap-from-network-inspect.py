import json


def main():
    with open("network-inspect.json") as f:
        networks = json.load(f)
        ips = container_ips(networks)
        dupes = list_duplicates(ips)
        print(dupes)


def container_ips(networks):
    ips = []
    for network in networks:
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
