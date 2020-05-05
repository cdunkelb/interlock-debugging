# Originally authored by Trap. Xin modified the script for running on macOS and enhanced it for not having to input network name.
# need 'brew install coreutils gawk'

for file in */dsinfo/dsinfo.txt; do
  echo "FILE=>${file}"
  gawk -v RS="" '/nnn/' $file |
  gawk '/^\[/{p=1}/^\]/{print; p=0} p' |             # filter json
  jq -r '.[]|
    ( .Containers[] | [.Name,.IPv4Address|split("/")[0]] ),
    ( .Services[]   |
        ["VIP",.VIP],
        ( .Tasks[] | [.Name,.EndpointIP] ) )
    | @tsv'      | # print "name ip" for local and networkdb endpoints
  sort -k2b,2 -s |  # sort by ip
  uniq -Df1      |  # filter for overlapping ips
  uniq -u          `# filter unduplicated task names`
done |
column -t

# Usage:
# $0 > t 2>/dev/null
# grep -v ^FILE -B 1 t 
