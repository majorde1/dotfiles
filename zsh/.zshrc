source "$XDG_CONFIG_HOME/zsh/aliases"

# ZSH options
setopt AUTO_PARAM_SLASH
setopt INTERACTIVE_COMMENTS
unsetopt CASE_GLOB

# Initialize auto-complete
autoload -Uz compinit; compinit

# Autocomplete hidden files
_comp_options+=(globdots)
source ~/dotfiles/zsh/external/completion.zsh
fpath=($ZDOTDIR/external $fpath)

# Async support
source ~/.zsh-async/async.zsh

# Prompt config
autoload -Uz prompt_setup; prompt_setup

# Push the current directory visited on to the stack
setopt AUTO_PUSHD
# Do not store duplicate directories in the stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after using pushd or popd.
setopt PUSHD_SILENT
# Bind Ctrl-R for reverse history
bindkey '^R' history-incremental-search-backward

# Enable Vi Mode
bindkey -v
export KEYTIMEOUT=1
autoload -Uz cursor_mode && cursor_mode

# Vim mapping for completion navigation
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Jump to parent directories
source ~/dotfiles/zsh/external/bd.zsh

# Source convenience scripts
source ~/dotfiles/zsh/scripts.sh

# Fuzzy finder
if [ $(command -v "fzf") ]; then
  if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
    # Ubuntu location
    source /usr/share/doc/fzf/examples/completion.zsh
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  else
    # Arch Linux location
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
  fi
fi

# Auto-start i3
if [ "$(tty)" = "/dev/tty1" ];
then
  pgrep i3 || exec startx "$XDG_CONFIG_HOME/X11/.xinitrc"
fi

# Enable syntax highlighting, keep this last.
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  # Ubuntu location
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  # Arch Linux location
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Syntax highlighting colors
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=14
ZSH_HIGHLIGHT_STYLES[precommand]=fg=14
ZSH_HIGHLIGHT_STYLES[arg0]=fg=14
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=14
ZSH_HIGHLIGHT_STYLES[command-substitution]=fg=14
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=red
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=red
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=red
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[comment]=fg=blue
ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[globbing]=none
ZSH_HIGHLIGHT_STYLES[default]=none

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/majorde/.sdkman"
[[ -s "/home/majorde/.sdkman/bin/sdkman-init.sh" ]] && source "/home/majorde/.sdkman/bin/sdkman-init.sh"
