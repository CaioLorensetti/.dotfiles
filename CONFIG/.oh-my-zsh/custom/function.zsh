kcfg() {
clear
declare -a _nicknames=("AWS - production-sa-east-1a" "GCP - gcp.prd.sp1a" "DEV - gcp.dev.uc1a")
declare -a _contexts=("production-sa-east-1a" "gcp.prd.sp1a" "gcp.dev.uc1a")

_selected_nickname=$(printf '%s\n' "${_nicknames[@]}" | fzf --reverse)

if [[ -z ${_selected_nickname} ]]; then
    echo "Nenhum contexto selecionado"
    return
fi

index=$(printf '%s\n' "${_nicknames[@]}" | grep -n "${_selected_nickname}" | cut -d: -f1)
_context=${_contexts[$index]}

declare -a _find_by=("Aplicação" "Namespace")

_selected_find_by=$(printf '%s\n' "${_find_by[@]}" | fzf --reverse)

if [[ -z ${_selected_find_by} ]]; then
    echo "Nenhum critério selecionado"
    return
fi

if [[ ${_selected_find_by} == "Aplicação" ]]; then
    _desired_application=$(kubectl get deployments --all-namespaces -o json --context=${_context} | jq -r '.items[].metadata.name' | fzf --reverse)

    if [[ -z ${_desired_application} ]]; then
        echo "Nenhum aplicativo selecionado"
        return
    fi

    _namespaces=$(kubectl get deployments --all-namespaces -o json --context=${_context} | jq -r --arg desired_app "$_desired_application" '.items[] | select(.metadata.name == $desired_app) | .metadata.namespace')
else
    _namespaces=$(kubectl get namespaces -o name --context=${_context} | fzf --reverse | awk -F/ '{print $2}')

    if [[ -z ${_namespaces} ]]; then
        echo "Nenhum namespace selecionado"
        return
    fi
fi

kubectl config set-context ${_context} --namespace=${_namespaces} > /dev/null
kubectl config use-context ${_context} > /dev/null

echo -e "Contexto alterado para \033[0;32m${_context}\033[0m com namespace \033[0;32m${_namespaces}\033[0m"
}


__get_location_fzf () {
    hidden=$1
    if [[ "$1" == "H" ]]; then
      destination=$(fd -H -E .git -E snap -E Pictures -E Videos -E Music -E Downloads -E kubeuol | fzf --reverse --preview="if [ -d {} ]; then echo \"Directory: {}\" && (cd {} && ls -lh); else bat --color=always {}; fi" ) 
    else
      destination=$(fd -E .git -E snap -E Pictures -E Videos -E Music -E Downloads -E kubeuol | fzf --reverse --preview="if [ -d {} ]; then echo \"Directory: {}\" && (cd {} && ls -lh); else bat --color=always {}; fi" )
    fi
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

vh () {
    destination=$(__get_location_fzf "H")
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


porta_0 () {
	sudo su -c 'echo 0 > /proc/sys/net/ipv4/ip_unprivileged_port_start'
}

