alias kc=kubectl
alias kcl='kubectl logs -f --tail=100'
alias kcll='kubectl get pods --sort-by=.metadata.creationTimestamp | cut -f 1 -d " " | tail -n 1 | xargs kubectl logs --tail=100 -f'
alias kce='kubectl exec -it'
alias kcy='kubectl get -o yaml'

# Global aliases for sorting/filtering
alias -g -- --by-host='--sort-by=.spec.nodeName'
alias -g -- --by-age='--sort-by=.metadata.creationTimestamp'
alias -g -- --by-ns='--sort-by=.metadata.namespace'
alias -g -- --count-by-host='-o custom-columns=node:spec.nodeName --no-headers | sort | uniq -c'

DEFAULT_SORT='--sort-by=.metadata.creationTimestamp'

# Logs for a deployment: kcld <deploy-name>
kcld () {
    local name="$1"; shift
    kubectl logs -f --tail=100 deploy/$name $@
}
_kcld () {
    _arguments "1: :($(kubectl get deploy -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}'))"
}
compdef '_kcld' kcld

# Run kubectl command across all namespaces: kcall get pods
kcall () {
    local verb="$1"; shift
    kubectl $verb --all-namespaces $@
}
_kcall () {
    if ! type __start_kubectl >/dev/null 2>&1; then
        _kubectl
    fi
    _bash_complete -o default -F __start_kubectl
}
compdef '_kcall' kcall

# Get pods by app label across all namespaces: kla <app-label>
kla () {
    local label="$1"; shift
    kcall get pods -o wide $DEFAULT_SORT -l app=$label $@
}

# Get pods on a specific node: klh <node-name>
klh () {
    local node="$1"; shift
    kcall get pods --field-selector spec.nodeName=$node $@
}
_klh () {
    _arguments "1: :($(kubectl get nodes -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}'))"
}
compdef '_klh' klh

# Get pods in a namespace: klp [namespace]
klp () {
    local args=''
    if [[ -n "$1" && "$1" != -* ]]; then
        args="-n $1"
        shift
    fi
    kubectl get pods -o wide $DEFAULT_SORT ${=args} $@
}
compdef '_kubens' klp

# Get services, deployments, daemonsets, statefulsets: kln [namespace]
kln () {
    local args=''
    if [[ -n "$1" && "$1" != -* ]]; then
        args="-n $1"
        shift
    fi
    kubectl get svc,deploy,ds,sts ${=args} $@
}
compdef '_kubens' kln

# Show pods using more than 0.1 core
khogs () {
    kubectl top pods -A | grep -ve ' \d\{1,2\}m ' | phe sort -k 3 -h -r
}

# Restart a deployment: krd <deploy-name> [-n namespace]
krd () {
    local deploy="$1"
    shift

    local patch_str='{"spec": {"template": {"metadata": {"annotations": {"restartTrigger":"'
    patch_str+="$(date)"
    patch_str+='"}}}}}'

    kubectl patch deploy "$deploy" -p "$patch_str" $@
}
_krd () {
    _arguments "1: :($(kubectl get deploy -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}'))"
}
compdef '_krd' krd
