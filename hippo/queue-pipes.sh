#!/bin/bash

ls -1 --color=no pipe-*.sh | perl -wpne 's/^pipe-//; s/.sh$//;' | xargs -rn1 '-IX' sh -c 'sbatch -e slurm-X.out -o slurm-X.out pipe-X.sh'
