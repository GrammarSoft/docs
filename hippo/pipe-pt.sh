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
| /usr/bin/time -o output-NUMBER.time /work/xperohs/parsers/por/bin/runport --frames 2>output-NUMBER.err \
| gzip -1c > output-NUMBER.gz

chgrp xperohs *NUMBER*
chmod g+rw *NUMBER*
