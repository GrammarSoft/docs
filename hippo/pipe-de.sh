#! /bin/bash
#
#SBATCH --qos=scavenger
#SBATCH --requeue
#SBATCH --nodes 1             # number of nodes
#SBATCH --ntasks-per-node 8   # number of cores per node
#SBATCH --time 4:00:00        # max time (HH:MM:SS)

# Setup
. /work/xperohs/init.sh

cd WORKDIR

zcat "split-NUMBER.gz" \
| /work/xperohs/parsers/bin/uni-to-text.pl 2>/dev/null \
| sed 's/\\xA0/ /g' \
| /usr/bin/time -o time-NUMBER.log /work/xperohs/parsers/ger/bin/gergram --frame-semdep 2>error-NUMBER.log \
| gzip -c > output-NUMBER.gz
