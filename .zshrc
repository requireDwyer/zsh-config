# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/aidan/.zshrc'

# autoload -Uz compinit
# compinit

# End of lines added by compinstall

# luke smith stuff

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# =============================================

export KEYTIMEOUT=1
export VISUAL=vim
export EDITOR="$VISUAL"

# ----- PROMPT START -----

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%F{255}on%f %F{147} %b%f %F{9}%m%f%F{208}%u%f%F{154}%c%f'

zstyle ':vcs_info:*' unstagedstr '🟨'
# Default 
# zstyle ':vcs_info:*' unstagedstr 'M'
zstyle ':vcs_info:*' stagedstr '✅'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='🟥'
  fi
}

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
NEWLINE=$'\n'

PROMPT='[%f%F{204}${PWD/#$HOME/~}%f%F{255}]%f ${vcs_info_msg_0_}${NEWLINE}🚀 %F{204}❯%f '

# Below Line is default prompt
# PROMPT='%F{213}%n%f %F{255}at%f %F{177}%m%f %F{255}in [%f%F{204}${PWD/#$HOME/~}%f%F{255}]%f ${vcs_info_msg_0_}${NEWLINE}🚀 %F{204}❯%f '

# ----- ALIAS START -----

# neovim
alias e='nvim'

# Change ls to lsd 
alias ls='lsd --group-dirs first'
alias lsl='lsd -l --group-dirs first'
alias lsla='lsd -la --group-dirs first'


# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/plug-ins/zsh-you-should-use.zsh
