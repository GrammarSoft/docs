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

export "PATH=$PATH:/work/xperohs/docs/corpus"
zcat output-NUMBER.gz | perl -Mutf8 -we 'my $s=""; while (<STDIN>) { if (/^<s/) {$s=$_;} if (/ #1->/) { print "</s>\n$s"; } print; }' | parse_cqp.pl | depcqp-append.pl | perl -Mutf8 -we 'while(<STDIN>) { if (/^<s/) {$_="";} if (/^(?:\x{a4}|¤)\t([^\t]+)/) {$a=$1; $ a=~ s/"-/" /g; print "<s $a>\n"; s/^(\x{a4}|¤)\t[^\t]+/\x{a4}\t\x{a4}/;} print; }' | perl -Mutf8 -we 'my $i=0; while(<STDIN>) { if (/^<s /) {++$i; s/^<s id="([^"]+)"/<s id="$i"/; s/( l?stamp="\d+-\d+-\d+)-/$1 /g;} print;}' | gzip -c >output-NUMBER.manatee.gz

chgrp xperohs *NUMBER*
chmod g+rw *NUMBER*
