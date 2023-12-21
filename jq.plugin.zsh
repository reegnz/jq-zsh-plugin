if [[ -o zle ]]; then

  __lbuffer_strip_trailing_pipe() {
    # Strip a trailing pipe and its surrounding whitespace.
    sed -E 's/[[:space:]]*\|[[:space:]]*$//' <<<"$LBUFFER"
  }

  __get_query() {
    if [ "${JQ_ZSH_PLUGIN_EXPAND_ALIASES:-1}" -eq 1 ]; then
      unset 'functions[_jq-plugin-expand]'
      functions[_jq-plugin-expand]=$(__lbuffer_strip_trailing_pipe)
      (($+functions[_jq-plugin-expand])) && COMMAND=${functions[_jq-plugin-expand]#$'\t'}
      # shellcheck disable=SC2086
      jq-repl -- ${COMMAND}
      return $?
    else
      # shellcheck disable=SC2086
      jq-repl -- $(__lbuffer_strip_trailing_pipe)
      return $?
    fi
  }

  jq-complete() {
    local query
    query="$(__get_query)"
    local ret=$?
    if [ -n "$query" ]; then
      LBUFFER="$(__lbuffer_strip_trailing_pipe) | ${JQ_REPL_JQ:-jq}"
      [[ -z "$JQ_REPL_ARGS" ]] || LBUFFER="${LBUFFER} ${JQ_REPL_ARGS}"
      LBUFFER="${LBUFFER} '$query'"
    fi
    zle reset-prompt
    return $ret
  }

  zle -N jq-complete
  # bind `alt + j` to jq-complete
  bindkey '\ej' jq-complete
fi

export PATH=$PATH:${0:A:h}/bin
