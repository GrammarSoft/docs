#!/bin/bash

ls -1 --color=no | grep ^0 | xargs -rn1 '-IX' sh -c 'cd X; cp -af ../pipe.sh ./ && /work/xperohs/make-pipes.sh'
