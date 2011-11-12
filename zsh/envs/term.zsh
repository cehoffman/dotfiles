if [[ -o interactive ]]; then
  function set_title() {
    case $TERM in
      xterm*|rxvt*)
        print -Pn "\e]0;%n@%m:$*\a"
        ;;
      screen*)
        print -Pn "\e]0;$2\a"
        print -Pn "\ek%n@%m $1\e\\"
        ;;
    esac
  }

  function title_preexec () {
    local -a cmd; cmd=(${(z)1})
    local exe=${cmd[(r)^(*=*|sudo)]}
    local exei=${cmd[(i)^(*=*|sudo)]}
    local -a extra; extra=(${cmd[$exei+1,-1]})

    case $exe in
      fg|%*)
        if [[ $exe == 'fg' && (($#cmd == 1))]]; then
          # No arguments, need to find the job
          cmd=(builtin jobs -l %+)
        elif [[ $exe == 'fg' ]]; then
          # Find the specified job
          cmd=(builtin jobs -l ${(Q)extra[1]})
        else
          cmd=(builtin jobs -l ${(Q)exe})
        fi

        local -A jt; jt=(${(kv)jobtexts}) # make a copy of jobtexts for subshell

        # Run the saved command from above for job lookup
        # This is easier than trying to parse $rest manually
        $cmd >>(read num rest
                cmd=(${(z)${(e):-\$jt$num}})
                exe=${cmd[(r)^(*=*|sudo)]}
                exei=${cmd[(i)^(*=*|sudo)]}
                extra=(${cmd[$exei+1,-1]})
                set_title $exe $extra) 2>/dev/null
        ;;
      exec)
        # doing an exec so bring it off the list
        exe=${extra[(r)^(*=*|sudo|-*)]}
        exei=${extra[(i)^(*=*|sudo|-*)]}
        extra=(${extra[$exei+1,-1]})
        ;& # Fall through
      *)
        set_title $exe $extra
        ;;
    esac
  }

  function title_precmd () {
    set_title %~ $(basename $SHELL)
  }

  preexec_functions+=title_preexec
  precmd_functions+=title_precmd
fi