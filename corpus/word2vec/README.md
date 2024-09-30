# word2vec encoding

```
# Convert existing verticalized corpus to sentences of lex_POS tokens
zstdcat dan_corpusname.zst | time ./conv.php >sents.txt

# Train word2vec
# The output filename MUST be verbatim model.300.sg.w2v
time ./train-sg.py sents.txt model.300.sg.w2v 2>&1 | tee out.log

# Upload to backends
rsync -rltvzP model.300.sg.w2v* manatee@backends.gramtrans.com:storage/word2vec/dan_corpusname/
```

Then add `'word2vec' => ['_N'],` to corpus' entry in `config.php`.
