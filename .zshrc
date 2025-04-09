#eval "$(starship init zsh)"
# Aliases
alias cargo="RUSTFLAGS='-Z threads=8' cargo +nightly"
alias cls="clear"
alias reload="source ~/.zshrc"
alias cdpro="cd ~/projects"
alias wip="cdwip"
alias cdt="cdtag"
alias fzf="sk" # install sk instead of fzf using: cargo install skim
alias dcu="docker compose up -d"

# Oh My Zsh Setup
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# CUDA Configuration
# export CUDA_VERSION=12
# export CUDA_HOME="/usr/local/cuda-${CUDA_VERSION}"
# export CUDA_PATH="${CUDA_HOME}"
# export PATH="${CUDA_PATH}/bin:${PATH}"
# export LIBRARY_PATH="${CUDA_PATH}/lib64:${LIBRARY_PATH}"
# export LD_LIBRARY_PATH="${CUDA_PATH}/lib64:${LD_LIBRARY_PATH}"
# export LD_LIBRARY_PATH="${CUDA_PATH}/extras/CUPTI/lib64:${LD_LIBRARY_PATH}"
# export NVCC="${CUDA_PATH}/bin/nvcc"
# export CFLAGS="-I${CUDA_PATH}/include ${CFLAGS}"
#  export PATH="/usr/local/cuda-8.0/bin:$PATH"
#  export LD_LIBRARY_PATH="/usr/local/cuda-8.0/lib64:$LD_LIBRARY_PATH"

# Golang
export PATH="$PATH:/usr/local/go/bin"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Loads nvm bash_completion

# Bun Package Manager
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Zsh Plugins
# Zsh Syntax Highlighting
if [ -d "$HOME/.zsh/zsh-syntax-highlighting" ]; then
  source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Zsh Autosuggestions
if [ -d "$HOME/.zsh/zsh-autosuggestions" ]; then
  source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Zsh History Substring Search
if [ -d "$HOME/.zsh/zsh-history-substring-search" ]; then
  source "$HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi

# CUDA Paths
# export CUDA_PATH=/usr/local/cuda
# export PATH=$PATH:/usr/local/cuda/bin
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64

# Homebrew Setup
if [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Local Binary Paths
export PATH="$HOME/.local/bin:$PATH"

cdwip() {
    # local projects_dir=~/projects  # Change this to your projects directory
    # local wip_projects

    # # Get WIP projects tagged with "wip" using TMSU
    # wip_projects=$(tmsu files WIP | sk --prompt="Select WIP project: " --height=15 --reverse)

    # # If user selected a project, cd into it
    # if [[ -n "$wip_projects" ]]; then
    #     cd "$wip_projects" || echo "Failed to enter $wip_projects"
    # else
    #     echo "No project selected."
    # fi

    cdtag WIP
}


cdtag() {
    local projects_dir=~/projects  # Change this to your projects directory
    local tags="$@"
    local matched_projects

    if [[ -z "$tags" ]]; then
        echo "Usage: cdtag <tag1> [tag2] [tag3]..."
        return 1
    fi

    # Get projects matching the given tags using TMSU
    matched_projects=$(tmsu files "$tags" | sk --prompt="Select project ($tags): " --height=15 --reverse)

    # If user selected a project, cd into it
    if [[ -n "$matched_projects" ]]; then
        cd "$matched_projects" || echo "Failed to enter $matched_projects"
    else
        echo "No project selected."
    fi
}


fco() {
    git branch --all | fzf --height=15 --reverse | xargs git checkout
}
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

# In .zshrc
for plugin in ~/.zsh/plugins/*; do
  f="$plugin/${plugin##*/}.zsh"
  [[ -f "$f" ]] && source "$f"
done
