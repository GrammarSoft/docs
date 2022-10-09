zstdcat twitter-da.cqp.zstd | u2h | PERL_UNICODE= LC_ALL=C perl -wpne 's@\\([uU])([0-9A-Fa-f]{4,8})@~$1$2@g;' | pigz -1c > twitter-da.cqp.gz
