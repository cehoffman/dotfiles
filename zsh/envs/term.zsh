if [[ -o interactive ]]; then
  function set_title() {
    case $TERM in
      xterm*|rxvt*)
        print -Pn "\e]0;%n@%m:$*\a"
        ;;
      screen*)
        # print -Pn "\e]0;$1\a"
        print -Pn "\ek%m $1\e\\"
        [[ -n "$TMUX" && -z "$ITERM_PROFILE" ]] && print -Pn "\ePtmux;\e\ek%m $1\e\\"
        ;;
    esac
  }

  function __real_exe() {
    local exe="$1"
    while (( $+aliases[$exe] && $+commands[$exe] == 0 )); do
      exe=("${(Z+C+)aliases[$exe]}")
      exe=${exe[(r)^(*=*|sudo|-*|nocorrect|noglob|builtin|command)]}
    done
    echo $exe
  }

  function title_preexec () {
    local -a cmd; cmd=(${(Z+C+)1})
    local exei=${cmd[(i)^(*=*|sudo|-*|nocorrect|noglob|builtin|command)]}
    local exe="$(__real_exe "$cmd[$exei]")"
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
                cmd=(${(Z+C+)${(e):-\$jt$num}})
                exei=${cmd[(i)^(*=*|sudo|-*|nocorrect|noglob|builtin|command)]}
                exe="$(__real_exe "$cmd[$exei]")"
                extra=(${cmd[$exei+1,-1]})
                set_title $exe $extra) 2>/dev/null
        ;;
      exec)
        # doing an exec so bring it off the list
        exei=${extra[(i)^(*=*|sudo|-*)]}
        exe="$(__real_exe "$cmd[$exei]")"
        extra=(${extra[$exei+1,-1]})
        ;& # Fall through
      *)
        set_title $exe $extra
        ;;
    esac
  }

  function title_precmd () {
    set_title ${${(ps:/:)PWD/$HOME/\~}[-1]} $SHELL:t
  }

  preexec_functions+=title_preexec
  precmd_functions+=title_precmd
fi
