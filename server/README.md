# Server Setup
Based on Ubuntu 22.04 LTS for corp2.visl.dk

## Environment
* `/etc/environment`:
  * `PERL_UNICODE=SDA`
  * `EDITOR=mcedit`
  * `DOCKER_BUILDKIT=1`
  * `BUILDKIT_PROGRESS=plain`
  * `PROGRESS_NO_TRUNC=1`
* Set `/etc/timezone` to `Etc/UTC`
* Set `/etc/default/locale` to `C.UTF-8`

## Filesystem
* Ensure `btrfs` mounts have `noatime,compress-force=zstd:15,ssd,discard`, and `swap` mounts have `discard`
* Clone partitions:
```
sfdisk -d /dev/nvme0n1 > ptable
# ...edit ptable...
sfdisk /dev/nvme1n1 < ptable
```
* Enable both swaps
* Set up btrfs RAID:
```
btrfs device add /dev/nvme1n1p1 /boot
btrfs balance start -dconvert=raid1 -mconvert=raid1 /boot
```
* Set up [cryptsetup encrypted partitions](https://wiki.archlinux.org/title/dm-crypt/Device_encryption) with remote unlock on boot, [ensure discard](https://wiki.archlinux.org/title/Dm-crypt/Specialties#Discard/TRIM_support_for_solid_state_drives_(SSD)) `cryptsetup --allow-discards --persistent refresh crypt-root` is set, btrfs RAID0 them.
* Remote mount script akin to:
```
#!/bin/bash
set -e
PASS=$(curl -s -d 'Key=Pass' https://corp.hum.sdu.dk/crypt.php)

echo -n "$PASS" | cryptsetup open UUID=78300cfb-a8b9-4791-b298-b02b882d7742 crypt-nvme0
echo -n "$PASS" | cryptsetup open UUID=93106265-d7a7-4c6d-862c-baf96be800a2 crypt-nvme1

mount -onoatime,compress-force=zstd:15,ssd,discard LABEL=data /media/data
```

## Packages
* `apt-get -qf install mc iotop htop pigz zstd`
* Install latest [HWE edge kernel](https://wiki.ubuntu.com/Kernel/LTSEnablementStack): `apt-get install --install-recommends linux-generic-hwe-22.04-edge`
* Create `/etc/apt/apt.conf.d/99phased` with `APT::Get::Always-Include-Phased-Updates "1";`
* `wget https://apertium.projectjj.com/apt/install-nightly.sh -O - | bash`
* Install [Webmin](https://webmin.com/)
* Ensure time is synced with `europe.pool.ntp.org`
* Install [Docker](https://docs.docker.com/engine/install/) and ensure `/etc/docker/daemon.json` has `{"experimental": true}`

## Other
* Create `/etc/sysctl.d/99-iotop.conf` with `kernel.task_delayacct=1` and/or change `GRUB_CMDLINE_LINUX_DEFAULT` with `delayacct`. This lets `iotop` show better statistics.
* Enable zswap in `/etc/rc.local` with `echo 1 > /sys/module/zswap/parameters/enabled`
* `ln -s /usr/lib/mc/mc.sh /etc/profile.d/mc.sh`
* Change `~/.bashrc` to disable `color_prompt` and `force_color_prompt`
* Create `/etc/profile.d/zz_history_long.sh` with:
```
cat ~/.history_long | LC_ALL=C uniq > ~/.history_long.new.$$
rm -f ~/.history_long
mv ~/.history_long.new.$$ ~/.history_long

export HISTSIZE=20000
export HISTFILESIZE=60000
export HISTCONTROL=ignoredups
export HISTIGNORE="?:??:exit:logout"
export HISTTIMEFORMAT="%s "
export PROMPT_COMMAND='echo $$ $USER "$(history 1)" >> ~/.history_long;echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
shopt -s histappend
shopt -s cdspell
shopt -s dirspell
shopt -s nocaseglob

export IGNOREEOF=1
```
