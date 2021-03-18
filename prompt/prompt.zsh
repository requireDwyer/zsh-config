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

