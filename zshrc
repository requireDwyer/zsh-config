# Path to your oh-my-zsh installation.
export ZSH="/home/aidan/.oh-my-zsh"

# --- THEME ---
source $HOME/.config/zsh/prompt/spaceship.zsh

# --- PLUG-INS ---
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ----- GENERAL -----
source $HOME/.config/zsh/general.zsh
# ----- ALIASES ------
source $HOME/.config/zsh/aliases/git.zsh
source $HOME/.config/zsh/aliases/general.zsh
# ----- Plug-ins -----
source $HOME/.config/zsh/plug-ins/zsh-you-should-use.zsh # source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh #Load zsh-syntax-highlighting; should be last.
