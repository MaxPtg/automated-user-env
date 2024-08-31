#=============================================================
#=== CUSTOM .bashrc FILE =====================================
#=============================================================

#=== oh-my-bash ==============================================

# Set Oh-My-Bash theme
OSH_THEME="custom_theme"

# Enable command auto-correction
ENABLE_CORRECTION="true"

# Display red dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Set history timestamp format
HIST_STAMPS='dd.mm.yyyy'

# Enable sudo usage by Oh-My-Bash
OMB_USE_SUDO=true

# Enable display of Python virtualenv and condaenv
OMB_PROMPT_SHOW_PYTHON_VENV=true

# Completions to load
completions=(
    git
    ssh
    docker
    docker-compose
    pip
    pip3
    tmux
    go
    npm
    nvm
    tmux
)

# Aliases to load
aliases=(
    general
)

# Plugins to load
plugins=(
    git
    bashmarks
    cargo
    goenv
    golang
)

# Source Oh-My-Bash
[ -f $OSH/oh-my-bash.sh ] && source $OSH/oh-my-bash.sh

#=== CUSTOM CONFIGURATIONS ===================================

# aliases
export EDITOR='nano'
alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean'
alias rcedit='nano ~/.bashrc && source ~/.bashrc'
alias rc="source ~/.bashrc"

# functions
function mkcd() {
    mkdir -p "$1" && cd "$1"
}
