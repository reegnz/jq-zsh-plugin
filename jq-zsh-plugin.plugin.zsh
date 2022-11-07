if [[ -o zle ]]; then

__get_query() {
    if [ "${JQ_ZSH_PLUGIN_EXPAND_ALIASES:-1}" -eq 1 ]; then
        unset 'functions[_jq-plugin-expand]'
        functions[_jq-plugin-expand]=${LBUFFER}
        (($+functions[_jq-plugin-expand])) && COMMAND=${functions[_jq-plugin-expand]#$'\t'}
        jq-repl -- ${COMMAND}
        return $?
    else
        jq-repl -- ${LBUFFER}
        return $?
    fi
}

jq-complete() {
    local query="$(__get_query)"
    local ret=$?
    if [ -n "$query" ]; then
        LBUFFER="${LBUFFER} | ${JQ_REPL_JQ:-jq}"
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
