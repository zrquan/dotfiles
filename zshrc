# zmodload zsh/zprof

# Powerlevel10k instant prompt (keep near top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh  # load personal prompt config
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme || echo "Install powerlevel10k first (use yay)"

# Basic paths
export PATH="$HOME/.local/bin:$HOME/.dotfiles/bin:$HOME/.config/emacs/bin:$PATH"

# Go path
export GOPATH="$HOME/.local/share/go"
export PATH="$GOPATH/bin:$PATH"

# Locale
export LANG=en_US.UTF-8

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode disabled
zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'icons' yes
plugins=(emacs fzf docker docker-compose eza)
source "$ZSH/oh-my-zsh.sh"

# Clipboard helper based on session type
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
  COPY="xclip -sel clip"
elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  COPY="wl-copy"
else
  echo "Unknown graphical environment."
  COPY=""
fi

# Enhance fzf
export FZF_DEFAULT_OPTS="
  --marker ▏ --pointer » --prompt '$ '
  --highlight-line
  --layout reverse
  --info inline-right
  --border
  --multi"
# fzf color theme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:#3c3836,bg:#1d2021,spinner:#8ec07c,hl:#83a598"\
" --color=fg:#bdae93,header:#83a598,info:#fabd2f,pointer:#8ec07c"\
" --color=marker:#8ec07c,fg+:#ebdbb2,prompt:#fabd2f,hl+:#83a598"
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --height 60%
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | $COPY)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Editor: use vim over SSH, emacs locally
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='emacs'
fi

# Aliases
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias listen="lsof -P -i -n | fzf" # 查看网络连接
alias psf="ps aux | fzf"
alias open="xdg-open"
alias magit='emacs -e "(magit-status \"$(git rev-parse --show-toplevel)\")"'
alias vv="source .venv/bin/activate"
alias cat="bat -p --theme=base16"
alias tldr="navi"
alias krestart="killall plasmashell && kstart5 plasmashell"
alias c="code"
alias fd="fd --hidden --no-ignore"
alias dils="docker images | fzf --bind 'ctrl-d:become(docker rmi {3})' --header 'Press CTRL-D to delete the image'"

# compinit (ensure function completion)
fpath+=~/.zfunc
autoload -Uz compinit
# avoid insecure completion warnings
if [[ -w ~/.zcompdump || ! -f ~/.zcompdump ]]; then
  compinit -u
else
  compinit
fi

# zoxide is smarter cd
eval "$(zoxide init zsh)"

# nvm: lazy load to avoid slowing shell startup
export NVM_DIR="$HOME/.nvm"
nvm() { command nvm "$@"; }  # placeholder so typing nvm won't fail
autoload -Uz add-zsh-hook
_load_nvm() {
  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
  fi
  if [[ -s "$NVM_DIR/bash_completion" ]]; then
    source "$NVM_DIR/bash_completion"
  fi
  add-zsh-hook -d precmd _load_nvm
}
add-zsh-hook precmd _load_nvm

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# zprof
