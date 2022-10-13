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
export EDITOR=mcedit
