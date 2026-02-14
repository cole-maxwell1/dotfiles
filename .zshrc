# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load local environment secrets if the file exists
if [ -f "$HOME/.secrets" ]; then
    source "$HOME/.secrets"
fi

###############################################
# Cole's $PATH configs
###############################################

# Make .local/bin directory if it doesn't exist for user binaries
if [[ ! -d $HOME/.local/bin ]]; then
    mkdir -p $HOME/.local/bin
fi

# Add .local/bin to $PATH if it doesn't exist
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  export PATH=$PATH:$HOME/.local/bin
fi

# Add script binaries to $PATH if they exist
if [[ -d $HOME/.scripts && ":$PATH:" != *":$HOME/.scripts:"* ]]; then
    export PATH=$PATH:$HOME/.scripts
fi

# Linux specific
# if [[ "$(uname -s)" == "Linux" ]]; then
    
# fi

# MacOS specific
if [[ "$(uname -s)" == "Darwin" ]]; then
    # Add python3.8 $PATH if installed and not already in $PATH
    if [[ -d $HOME/Library/Python/3.8/bin && ":$PATH:" != *":$HOME/Library/Python/3.8/bin:"* ]]; then
        export PATH=$PATH:$HOME/Library/Python/3.8/bin
    fi
fi

# Add goland $PATH if installed and not already in $PATH
if [[ -d /usr/local/go/bin && ":$PATH:" != *":/usr/local/go/bin:"* ]]; then
    export PATH=$PATH:/usr/local/go/bin:~/go/bin
fi

# Add golang local bin path if installed and not already in $PATH
if [[ -d $HOME/go/bin && ":$PATH:" != *":$HOME/go/bin:"* ]]; then
    export PATH=$PATH:$HOME/go/bin
fi

# Add cargo path if installed and not already in $PATH
if [[ -d $HOME/.cargo/bin && ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
    export PATH=$PATH:$HOME/.cargo/bin
fi

###############################################
# zsh recommeded default configs
###############################################

# Autoload functions
autoload -Uz promptinit
autoload -Uz compinit

# Initialize prompt system
promptinit

# Set shell options
setopt histignorealldups sharehistory

# Use emacs keybindings even if EDITOR is set to vi
bindkey -e

# History settings
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Initialize completion system
compinit

# Completion configuration
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# Directory colors setup
if command -v dircolors &> /dev/null; then
    eval "$(dircolors -b)"
elif command -v gdircolors &> /dev/null; then
    eval "$(gdircolors -b)"
else
    # Define LS_COLORS directly if dircolors is not available
    export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=46:cd=43:su=37:sg=30:tw=42:ow=44"
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

###############################################
# Cole's custom prompt
###############################################

# Load Powerlevel10k theme if available
if [[ -f ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme ]]; then
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
fi

# Add autosuggestions (lazy load)
if [[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

###############################################
# Load Cole's custom aliases
###############################################

# Aliases for lsd (if installed)
# lsd is a rust ls alternative with a lot of features and fun colors/icons (Nerd Fonts required)
if command -v lsd &> /dev/null; then
    alias ls="lsd -F" # Add classification to file types
    alias la="lsd -AF" rg
    alias ll="lsd -lAF"
    alias lg="lsd -F --group-dirs=first" # Group directories first
    alias lt="lsd --tree --depth 5" # Show directory tree with depth of 5
    alias li="lsd -ilAF" # Show inode numbers
    else
    alias la="ls -a" # Show all files
    alias ll="ls -alh" # Show all files, long format, human readable sizes
    alias li="ls -ialh" # Show all files, long format, human readable sizes, inode numbers
fi
