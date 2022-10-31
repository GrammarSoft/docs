# Maintenance

## btrfs
* `mount | grep btrfs | awk '{print $3}' | xargs -rn1 '-I{}' sh -c 'echo "{}"; btrfs balance start -v -dusage=1 -musage=1 "{}"'`
* `blkid | grep btrfs | egrep -o '^/dev/[^:]+' | xargs -rn1 '-I{}' sh -c 'echo "{}"; btrfs scrub start "{}"'`
* `blkid | grep btrfs | egrep -o '^/dev/[^:]+' | xargs -rn1 '-I{}' sh -c 'echo "{}"; btrfs scrub status "{}"'`
