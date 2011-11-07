if [[ -a $(which virtualenvwrapper.sh) ]]; then
  # Virtualenvwrapper
  export WORKON_HOME="$HOME/.virtualenvs"
  hash -d virtualenvs=$WORKON_HOME
  source $(which virtualenvwrapper.sh)

  # Virtualenv
  export VIRTUALENV_USE_DISTRIBUTE=true

  # PIP config
  export PIP_VIRTUALENV_BASE=$WORKON_HOME
  export PIP_RESPECT_VIRTUALENV=true

  if [[ -f $WORKON_HOME/.active ]]; then
    workon `cat $WORKON_HOME/.active`
    cd ~
  fi
fi

function virtualenv_prompt_info() {
  if [[ -n $VIRTUAL_ENV ]]; then
    echo "$ZSH_THEME_VENV_PROMPT_PREFIX$(basename ${(q)VIRTUAL_ENV})$ZSH_THEME_VENV_PROMT_SUFFIX"
  fi
}
