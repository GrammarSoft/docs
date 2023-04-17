# Manatee

## Build Manatee
```
# Ideally build in a container or chroot and then export the result
apt-get install autoconf automake build-essential libtool autoconf-archive bison libpcre3-dev python3-dev swig
wget https://corpora.fi.muni.cz/noske/current/src/manatee-open-2.223.6.tar.gz
tar -zxvf manatee-open-2.223.6.tar.gz
cd manatee-open-2.223.6
autoreconf -fvi
./configure --with-pcre --prefix=/usr/local/manatee
make -j8
make install
```

## (alternatively) Docker image creation
```
docker run -it --rm --name manatee --hostname manatee -e LANG=en_US.UTF-8 -e LC_ALL=en_US.UTF-8 -v /home:/home -v /media:/media amd64/centos:7 /bin/bash

# Inside container
yum install epel-release
yum check-update
yum update
yum install python3 m4 parallel libtool-ltdl zstd
# At minimum:
# https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-2.223.6-1.el7.x86_64.rpm
# https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-python3-2.223.6-1.el7.x86_64.rpm
rpm -i /media/data/manatee*rpm

# In another shell
docker commit manatee manatee
echo 'FROM manatee' | docker build --squash -t manatee -
docker system prune -f

docker run -it --rm --name manatee --hostname manatee -e LANG=en_US.UTF-8 -e LC_ALL=en_US.UTF-8 -v /home:/home -v /media:/media manatee /bin/bash
```

# Encoding
```
export PYTHONPATH=/usr/local/manatee/lib/python3.10/site-packages "PATH=$PATH:/usr/local/manatee/bin"
zstdcat corpus.zstd | encodevert -c /home/manatee/storage/registry/dan_twitter
```

# Query
```
export PYTHONPATH=/usr/local/manatee/lib/python3.10/site-packages "PATH=$PATH:/usr/local/manatee/bin"
corpquery /home/manatee/registry/dan_twitter '[lex="musling"]' -a 'word,lex,pos' -s 's.id,s.tweet,s.stamp,s.lstamp'
```
