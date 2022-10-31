# Manatee

## Docker image creation
```
docker run -it --rm --name manatee --hostname manatee -e LANG=en_US.UTF-8 -e LC_ALL=en_US.UTF-8 -v /home:/home -v /media:/media amd64/centos:7 /bin/bash

# Inside container
yum install epel-release
yum check-update
yum install python3 m4 parallel libtool-ltdl
# At minimum:
# https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-2.208-1.el7.x86_64.rpm
# https://corpora.fi.muni.cz/noske/current/centos7/manatee-open/manatee-open-python3-2.208-1.el7.x86_64.rpm
rpm -i /media/data/manatee*rpm

# In another shell
docker commit manatee manatee
echo 'FROM manatee' | docker build --squash -t manatee -
docker system prune -f

docker run -it --rm --name manatee --hostname manatee -e LANG=en_US.UTF-8 -e LC_ALL=en_US.UTF-8 -v /home:/home -v /media:/media manatee /bin/bash
```
