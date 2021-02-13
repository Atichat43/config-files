# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
ZSH_DISABLE_COMPFIX=true

plugins=(
  git
  node
)

source $ZSH/oh-my-zsh.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export JAVA_HOME=`/usr/libexec/java_home`
# export AIRFLOW_HOME=~/airflow
# export SPARK_HOME="/Users/atichat/Desktop/spark"

export PATH="$HOME/.jenv/bin:$PATH"
export PATH="$PATH:$HOME/.npm-global/bin"
eval "$(direnv hook $SHELL)"
eval "$(jenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# ------------------------------------------------------------------
# Custom Aliases
# ------------------------------------------------------------------
alias ls='ls -alh'
alias lsd='ls -d */'
alias D='cd ~/Desktop/'
alias code_zsh='code ~/.zshrc'
alias source_zsh='source ~/.zshrc'
alias activate='source venv/bin/activate'

alias venv_create='python3 -m venv venv'

# genie ----------------------------------------------------------------------
alias cd_work_genie='cd ~/Desktop/work-genie'
alias work_genie_fe='cd ~/Desktop/work-genie/genie-frontend; code .'
alias work_genie_be='cd ~/Desktop/work-genie/tap-genie-backend; idea .'
alias work_genie_eval='cd ~/Desktop/work-genie/tadp-genie-evaluator-service; idea .'
alias work_genie_back='cd ~/Desktop/work-genie/tadp-genie-background-processing; idea .'

# geopulse ----------------------------------------------------------------------
alias cd_work_geopulse='cd ~/Desktop/work-geopulse'
alias work_geopulse_fe='cd ~/Desktop/work-geopulse/geopulse-frontend; direnv allow; code .'

# de ----------------------------------------------------------------------
alias cd_work_de='cd ~/Desktop/work-de'
alias work_de_airflow='cd ~/Desktop/work-de/de-airflow-tap-dags; code .'
alias work_de_dataflow='cd ~/Desktop/work-de/tap-dataflow-geopulse; idea .'

alias github='cd ~/Desktop/personal-github; ls'

# ------------------------------------------------------------------
# NPM Aliases
# ------------------------------------------------------------------
alias npm_run_test_coverage='npm run test:coverage'
alias npm_run_test_watch='npm run test:watch'
alias npm_ls_global='npm list -g --depth=0'

function jc() {
  local filename;
  filename="$*";
  osascript -e "jest --watch --verbose --coverage ${filename}";
}
# ------------------------------------------------------------------
# Git Functions
# ------------------------------------------------------------------
function gcof() {
  local number;
  number="$*";
  osascript -e "set the clipboard to \"git checkout feature/ANFD-${number}\"";
}

function gst() {
  gsta stash^{/"$1"}; #git stash apply stash^{/<regex>}
}

# Git log find by commit message
function glf() { git log --all --grep="$1"; }

# ------------------------------------------------------------------
# zsh
# ------------------------------------------------------------------
function git_current_user_email() {
  command git config user.email 2>/dev/null
}

# Plugin
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}$(git_current_user_email):(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ------------------------------------------------------------------
# Git Aliases
# ------------------------------------------------------------------
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

# ------------------------------------------------------------------
# Docker Aliases and function
# ------------------------------------------------------------------
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
