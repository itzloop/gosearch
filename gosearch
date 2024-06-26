# Inspired by https://www.jonathanh.co.uk/blog/current-word-completion/

ErrNoResults="no results"

gosearch_debug()
{
    local file="$GOSEARCH_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_gosearch () {
    local query=$1

    html=$(curl -s --location "https://pkg.go.dev/search?q=$query")

    # if result is empty, there are two possible scenarios:
    #   1. the query returned no actual results
    #   2. you are unlucky enough to be born in a country banned by the U.S
    if [[ -z "$html" ]]; then
        echo -n $ErrNoResults
    else
        packages=$(echo -n $html \
            | pup '.SearchSnippet-header-path text{}' \
            | sed -e 's/\///' \
            |  sed -r 's/^\((.*)\)$/\1/g')

        descriptions=$(echo -n $html \
            | pup '.SearchSnippet-synopsis text{}' \
            | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
         
        IFS=$'\n' packages=($(echo -n $packages))
        IFS=$'\n' descriptions=($(echo -n $descriptions))

        gosearch_debug "packages found: ${#packages[@]}"

        if [[ "${#packages[@]}" == "0" ]]; then
            echo -n $ErrNoResults
        else
            echo -n "$packages"
        fi
    fi
}

# ignore will fallback to default completion bound to ^I or <Tab>
ignore () {
    gosearch_debug "ignoring widget"
    zle ${default_completion:-expand-or-complete}
}

gosearch(){
    tokens=(${(z)LBUFFER})
    query="${tokens[-1]}"
    cmd="${tokens[1]}"
    subcmd="${tokens[2]}"

    gosearch_debug "query: $query, cmd: $cmd, subcmd: $subcmd"

    if [[ "$cmd" != "go" || "$subcmd" != "get" ]]; then
        ignore
        return 0
    fi

     gosearch_debug "go get has been called"

    # Only search for packages if no space is pressed
    # for exampe when go get http<Space> is in the buffer
    # and we hit <Tab>, do nothing!
    if [ "${LBUFFER[-1]}" != " " ]; then
        results=$(_gosearch $query)
        if [[ "$results" == "$ErrNoResults" ]]; then
            gosearch_debug "$results"
            ignore
            return 0
        fi

        result=$(echo -n "$results" | fzf -1)
        gosearch_debug "result: $result"
        tokens[-1]=$(printf "%q" "$result")
        LBUFFER=${tokens[@]}
    fi
}

# Record what ctrl+i is currently set to
# That way we can call it if currentword_default_completion doesn't result in anything
[ -z "$default_completion" ] && {
    binding=$(bindkey '^I')
    [[ $binding =~ 'undefined-key' ]] || default_completion=$binding[(s: :w)2]
    unset binding
}
zle     -N   gosearch
bindkey '^I' gosearch
