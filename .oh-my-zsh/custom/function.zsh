__get_location_fzf () {
    destination=$(fd -E .git -E snap -E Pictures -E Videos -E Music -E Downloads -E kubeuol | fzf --reverse --preview="if [ -d {} ]; then echo \"Directory: {}\" && (cd {} && ls -lh); else bat --color=always {}; fi"
)
    echo "$destination"
}

v () {
    destination=$(__get_location_fzf)
    if [ -z "$destination" ]
    then
        return
    fi
    if [ -z "$1" ]
    then
        if [ -d "$destination" ]
        then
            z "$destination"
        else
            nvim "$destination"
        fi
    else
        $1 "$destination"
    fi
}
