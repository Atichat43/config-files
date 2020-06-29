# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# ----------------------
# Zsh setting
# ----------------------
export ZSH="/Users/atichatlappanopakon/.oh-my-zsh"
ZSH_THEME="spaceship"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  docker
  node
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

#OPTIONS SPACESHIP
SPACESHIP_TIME_SHOW=true
SPACESHIP_HOST_SHOW=true
SPACESHIP_USER_SHOW=true
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false

SPACESHIP_TIME_FORMAT=%T

SPACESHIP_USER_PREFIX=''
SPACESHIP_DOCKER_PREFIX=''
SPACESHIP_NODE_PREFIX=''
SPACESHIP_DIR_PREFIX=''

#COPY FROM BASH_PROFILE
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/atichatlappanopakon/.sdkman"
[[ -s "/Users/atichatlappanopakon/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/atichatlappanopakon/.sdkman/bin/sdkman-init.sh"

#ENABLE direnv in zsh
eval "$(direnv hook $SHELL)"

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# npm outdated

# ----------------------
# Atichat Alias
# ----------------------
alias catEnv='cat .envrc'
alias catZsh='cat ~/.zshrc'

alias cdAtichat43='cd ~/Desktop/Atichat43'
alias cdApplications='cd ~/Applications'
alias cdFront='cd ~/Desktop/geopulse-frontend; nvm use; ls;'
alias cdDesktop='cd ~/Desktop'
alias cdDownloads='cd ~/Downloads'

alias codeFront='code --add ~/Desktop/geopulse-frontend'
alias codeEx='code --add ~/Desktop/experiment-geopulse-frontend'
alias codeNote='code ~/Desktop/Atichat43/.todoNote.notes'
alias codeZsh='code ~/.zshrc'

alias lst='ls -altF'

alias openAtichat43='open ~/Desktop/Atichat43'
alias openApplications='open ~/Applications'
alias openBack='open ~/Desktop/product-service-analytics'
alias openFront='open ~/Desktop/geopulse-frontend'
alias openDesktop='open ~/Desktop'
alias openDownloads='open ~/Downloads'

alias lockd="osascript -e 'tell application \"System Events\" to key code 12 using {control down, command down}'"
alias sleepd='pmset sleepnow'
alias cleand="killall 'Airmail 3' 'Bear' 'Calendar' 'Day One' 'LINE' 'Notes' 'Trello';"
alias readyWork="cleand ;open -a 'Google Chrome'; open -a 'Slack';"
alias morning="open -a 'Airmail 3'; open -a 'Calendar'; open -a 'Day One';"

function jc() {
  local filename;
  filename="$*";
  osascript -e "jest --watch --verbose --coverage ${filename}";
}

# ----------------------
# Git Aliases
# ----------------------
alias gbd='git branch -D'
alias gcob='git checkout -b'
alias gda='git diff HEAD'
alias gdlc='git diff HEAD^ HEAD'
alias glg='git fetch; git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gp='git pull'
alias gst='git stash'
alias gsta='git stash apply' # (stash@{2})
alias gstl='git stash list'
alias gstp='git stash pop' # (stash@{2})
alias gsts='git stash save' # (message)
alias gstd='git stash drop' # (stash@{2})
# git stash show -p (stash@{2})
#----------------------
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gau='git add --update'
alias gb='git branch -a'
alias gc='git commit'
alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcos='git checkout staging'
alias gcod='git checkout develop'
alias gd='git diff'
alias gi='git init'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gpr='git pull --rebase'
alias gr='git rebase'
alias gs='git status'
alias gss='git status --short'
alias guser='git config user.name; git config user.email;'
alias grpd='git remote prune origin --dry-run'
alias grp='git remote prune origin; git branch -a;'

# ----------------------
# Git Functions
# ----------------------
function gcof() {
  local number;
  number="$*";
  osascript -e "set the clipboard to \"git checkout feature/ANFD-${number}\"";
}

# Git log find by commit message
function glf() { git log --all --grep="$1"; }

# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }
