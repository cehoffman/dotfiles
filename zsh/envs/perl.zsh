typeset -xgUT PERL5LIB perl5_lib
perl5_lib[2,1]=(~/.homebrew/share/perl5(-/) ~/.perl/lib/perl5(-/))
export PERL_CPANM_OPT="-l $HOME/.perl"
