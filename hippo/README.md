# SDU Hippo / HPC Slurm Setup

* https://escience.sdu.dk/index.php/type-3-large-memory-hpc/
* https://docs.hpc-type3.sdu.dk/

## Modules and environment
Run `module avail` and note newest modules for `GCC`, `git`, `CMake`, and `binutils`.

Create `/work/xperohs/init.sh` with noted modules and environment variables:
```
module load GCC/11.3.0
module load CMake/3.23.1
module load git/2.36.0-nodocs
module load binutils/2.38

export "PATH=/work/xperohs/perl:/work/xperohs/run/perl5/bin:/work/xperohs/run/bin:$PATH"
export "LD_LIBRARY_PATH=/work/xperohs/run/lib:/work/xperohs/run/lib64:$LD_LIBRARY_PATH"

export PERL_MB_OPT="--install_base /work/xperohs/run/perl5"
export PERL_MM_OPT="INSTALL_BASE=/work/xperohs/run/perl5"
export PERL5LIB="/work/xperohs/run/perl5/lib/perl5"
export PERL_LOCAL_LIB_ROOT="/work/xperohs/run/perl5:$PERL_LOCAL_LIB_ROOT"
export PERL_UNICODE=SDA
```

Modify `~/.bash_profile` and append `. /work/xperohs/init.sh`. Open a new connection to get the new environment.

Run, replacing `tinod` with your user:
```
mkdir -pv /work/xperohs/build /work/xperohs/run/bin
scp /usr/local/bin/u2i /usr/local/bin/i2u tinod@hpc-type3.sdu.dk:/work/xperohs/run/bin/
```

## Perl
```
cd /work/xperohs/build
wget https://www.cpan.org/src/5.0/perl-5.36.0.tar.gz # or whichever is latest Perl at this time
tar -zxvf perl-5.36.0.tar.gz
cd perl-5.36.0

./Configure -Duselongdouble -Dprefix=/work/xperohs/run -Dusethreads -Uuselargefiles
# ...and answer a lot of questions, or just accept default for everything.
make -j
make -j test
make install

cpan -i Bundle::CPAN # Repeat until nothing new is installed
cpan -i IPC::Run MLDBM::Sync DB_File Lingua::Identify String::Approx Encode DBM_Filter Getopt::Long IPC::Open2 SDBM_File YAML
```

## ICU
```
cd /work/xperohs/build
wget https://github.com/unicode-org/icu/releases/download/release-71-1/icu4c-71_1-src.tgz # or whichever is latest ICU at this time
tar -zxvf icu4c-71_1-src.tgz
cd icu/source

./runConfigureICU Linux --prefix=/work/xperohs/run/
make -j
make -j check
make install
```

## CG-3
```
cd /work/xperohs/build
git clone https://github.com/GrammarSoft/cg3
cd cg3

cmake -DCMAKE_INSTALL_PREFIX=/work/xperohs/run .
make -j
./test/runall.pl
make install
```
