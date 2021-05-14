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

######################
# SETUP KDB BINDINGS #
######################
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"          ]] && bindkey -- "${key[Home]}"           beginning-of-line
[[ -n "${key[End]}"           ]] && bindkey -- "${key[End]}"            end-of-line
[[ -n "${key[Insert]}"        ]] && bindkey -- "${key[Insert]}"         overwrite-mode
[[ -n "${key[Backspace]}"     ]] && bindkey -- "${key[Backspace]}"      backward-delete-char
[[ -n "${key[Delete]}"        ]] && bindkey -- "${key[Delete]}"         delete-char
[[ -n "${key[Up]}"            ]] && bindkey -- "${key[Up]}"             up-line-or-history
[[ -n "${key[Down]}"          ]] && bindkey -- "${key[Down]}"           down-line-or-history
[[ -n "${key[Left]}"          ]] && bindkey -- "${key[Left]}"           backward-char
[[ -n "${key[Right]}"         ]] && bindkey -- "${key[Right]}"          forward-char
[[ -n "${key[PageUp]}"        ]] && bindkey -- "${key[PageUp]}"         beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"      ]] && bindkey -- "${key[PageDown]}"       end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}"     ]] && bindkey -- "${key[Shift-Tab]}"      reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"   backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}"  forward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

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

# Find package when command not found
source /usr/share/doc/pkgfile/command-not-found.zsh

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
