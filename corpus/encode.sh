#!/bin/bash
#Encodes a corpus into cqp and puts it into the registry.
#usage: encodeall inputfile outputCorpusName
export "PATH=/home/corpus/cwb-3.4.14/bin:$PATH"
name=$2
#source=../$1
source=$1
homedir=/home/corpus/$name
#make the dir
echo $source
echo $homedir
mkdir $homedir
cd $homedir

#encode
cwb-encode -d $homedir -t $source \
        -P lex -P extra -P pos -P morph -P func -P role -P dself -P dparent -P endmark \
        -P h_word -P h_lex -P h_extra -P h_pos -P h_morph -P h_func -P h_role -P h_dself -P h_dparent -P h_endmark \
        -S 's:0+id+tweet+comment+page+post'

rm -fv $homedir/h_endmark*

#add to registry
echo NAME \"$name\" >> /home/corpus/registry/$name
echo ID $name >> /home/corpus/registry/$name
echo HOME $homedir >> /home/corpus/registry/$name
echo ATTRIBUTE word >> /home/corpus/registry/$name
echo ATTRIBUTE lex >> /home/corpus/registry/$name
echo ATTRIBUTE extra >> /home/corpus/registry/$name
echo ATTRIBUTE pos >> /home/corpus/registry/$name
echo ATTRIBUTE morph >> /home/corpus/registry/$name
echo ATTRIBUTE func >> /home/corpus/registry/$name
echo ATTRIBUTE role >> /home/corpus/registry/$name
echo ATTRIBUTE h_word >> /home/corpus/registry/$name
echo ATTRIBUTE h_lex >> /home/corpus/registry/$name
echo ATTRIBUTE h_extra >> /home/corpus/registry/$name
echo ATTRIBUTE h_pos >> /home/corpus/registry/$name
echo ATTRIBUTE h_morph >> /home/corpus/registry/$name
echo ATTRIBUTE h_func >> /home/corpus/registry/$name
echo ATTRIBUTE h_role >> /home/corpus/registry/$name
echo ATTRIBUTE dself >> /home/corpus/registry/$name
echo ATTRIBUTE dparent >> /home/corpus/registry/$name
echo ATTRIBUTE h_dself >> /home/corpus/registry/$name
echo ATTRIBUTE h_dparent >> /home/corpus/registry/$name
echo ATTRIBUTE endmark >> /home/corpus/registry/$name
echo STRUCTURE s >> /home/corpus/registry/$name

#makeall
cwb-makeall -r /home/corpus/registry $name

#test
cwb-describe-corpus -r /home/corpus/registry $name
