#!/bin/bash

ls -1 --color=no split-*.gz | perl -wpne 's/^split-//; s/.gz$//;' |
{
while read N;
do
	S=$(zgrep -c '^<s ' "split-$N.gz")
	O=$(zgrep -c '^<s ' "output-$N.gz")
	if [[ $S != $O ]]; then
		echo "$N: $S != $O";
	fi
done
}
