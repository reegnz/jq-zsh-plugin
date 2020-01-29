if [[ -o zle ]]; then

__get_query() {
    eval "$LBUFFER" | jq-repl
    return $?
}

jq-complete() {
    local query="$(__get_query)"
    local ret=$?
    if [ -n "$query" ]; then
        LBUFFER="${LBUFFER} | jq -r '$query'"
    fi
    zle reset-prompt
    return $ret
}

zle -N jq-complete
# bind `alt + j` to jq-complete
bindkey '\ej' jq-complete
fi
