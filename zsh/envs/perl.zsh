typeset -xgUT PERL5LIB perl5_lib
perl5_lib=(~/.perl/lib/perl5 $perl5_lib)
export PERL_CPANM_OPT="-l $HOME/.perl"
