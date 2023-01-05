# Determine tags
zcat information.gz | perl -wpne 's@(<[^>]*>)@\n$1\n@g;' | grep '^<' | perl -wpne 'm@^</?([^\s>]+)@; $_="$1\n";' | sort | uniq

# Remove all non-article tags & convert article to s
zcat information.gz | perl -wpne 's@</?(a|b|i|span|font|strong|thorn)( [^>]*)/?>@@ig; s@</?(a|b|i|span|font|strong|thorn)/?>@@ig; s@(<[^>]*>)@\n$1\n@g;' | perl -wpne 's@^<article @<s @g; s@^</article>@</s>@g; s@<[^/s][^>]*>@@g; s@</[^s>][^>]*>@@g; s@^</?subheading>@@g;' | pigz -9c > information.clean.gz

# Split into chunks; Rename id; Remove superfluous time
zcat information.clean.gz | perl -wpne 's/ id="/ oid="/g; s/T00:00:00"/"/g;' | PERL_UNICODE= LC_ALL=C /work/xperohs/docs/corpus/chunk-tag.pl -s 10
