#!/bin/bash

rm -fv pipe-*.sh
PWD=`pwd`

ls -1 --color=no split-*.gz | perl -wpne 's/^split-//; s/.gz$//;' | xargs -rn1 '-IX' sh -c 'echo X; cat pipe.sh | perl -wpne "s/NUMBER/X/g;s@WORKDIR@'$PWD'@;" > pipe-X.sh; chmod +x pipe-X.sh'

chgrp xperohs pipe-*
chmod g+rw pipe-*
