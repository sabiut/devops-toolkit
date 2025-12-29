# DevOps Toolkit - Bash Configuration

# Shell options
set -o vi
shopt -s histappend
shopt -s checkwinsize

# History settings
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups

# Prompt customization
PS1='\[\033[1;36m\][devops-toolkit]\[\033[0m\] \[\033[1;34m\]\w\[\033[0m\] $ '

# Enable color support
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Common aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Docker aliases
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlogs='docker logs -f'
alias dprune='docker system prune -af'

# Kubernetes aliases
alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kl='kubectl logs -f'
alias kex='kubectl exec -it'
alias kctx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'

# Helm aliases
alias h='helm'
alias hl='helm list'
alias hi='helm install'
alias hu='helm upgrade'
alias hd='helm delete'

# Terraform aliases
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfv='terraform validate'
alias tff='terraform fmt'

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias glog='git log --oneline --graph'

# Ansible aliases
alias ap='ansible-playbook'
alias av='ansible-vault'
alias ai='ansible-inventory'

# AWS aliases
alias awsid='aws sts get-caller-identity'
alias awsregions='aws ec2 describe-regions --output table'

# Utility functions
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

function extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.rar)       unrar x "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xf "$1"    ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.Z)         uncompress "$1";;
            *.7z)        7z x "$1"      ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Kubernetes context/namespace display
function kube_ps1() {
    if command -v kubectl &> /dev/null; then
        context=$(kubectl config current-context 2>/dev/null)
        namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
        if [ -n "$context" ]; then
            echo " (k8s: ${context}/${namespace:-default})"
        fi
    fi
}

# Enable bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# kubectl completion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
    complete -F __start_kubectl k
fi

# helm completion
if command -v helm &> /dev/null; then
    source <(helm completion bash)
fi

# Tool verification on startup
echo "DevOps Toolkit ready. Run 'verify-tools.sh' to check installed tools."
