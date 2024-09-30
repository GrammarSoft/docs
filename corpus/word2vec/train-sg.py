#!/usr/bin/env python3
import gensim.models
import logging
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('inf')
parser.add_argument('outf')
args = parser.parse_args()

logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)

# export PYTHONHASHSEED=42
model = gensim.models.Word2Vec(corpus_file=args.inf, workers=12, sg=1, seed=42, sorted_vocab=1, vector_size=300) #, max_final_vocab=250000
model.wv.save(args.outf)
