#!/usr/bin/env php
<?php

$sent = '';
while ($l = fgets(STDIN)) {
	$l = trim($l);
	if ($l === '</s>') {
		$sent = trim($sent);
		if ($sent) {
			echo "$sent\n";
		}
		$sent = '';
		continue;
	}
	if (strpos($l, '<s ') === 0) {
		$sent = '';
		continue;
	}

	$l = explode("\t", $l);
	if ($l[0] === '¤') {
		continue;
	}
	if (strpos($l[0], 'http://') !== false || strpos($l[0], 'https://') !== false || strpos($l[0], 'ftp://') !== false) {
		$l[1] = 'URL';
	}
	$sent .= "{$l[1]}_{$l[3]} ";
}
