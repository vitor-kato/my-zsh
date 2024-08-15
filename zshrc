if [ -n "$ZSH_VERSION" ]; then

    # If you come from bash you might have to change your $PATH.
    # export PATH=$HOME/bin:/usr/local/bin:$PATH

    # Path to your oh-my-zsh installation.
    if [[ $EUID -ne 0 ]]; then
        export ZSH=$HOME/.oh-my-zsh
    else
        export ZSH=/root/.oh-my-zsh
    fi
    # Set name of the theme to load. Optionally, if you set this to "random"
    # it'll load a random theme each time that oh-my-zsh is loaded.
    # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
    #ZSH_THEME="robbyrussell"
    ZSH_THEME="ys"

    # Uncomment the following line to use case-sensitive completion.b
    # CASE_SENSITIVE="true"

    # Uncomment the following line to use hyphen-insensitive completion. Case
    # sensitive completion must be off. _ and - will be interchangeable.
    # HYPHEN_INSENSITIVE="true"

    # Uncomment the following line to disable bi-weekly auto-update checks.
    # DISABLE_AUTO_UPDATE="true"

    # Uncomment the following line to change how often to auto-update (in days).
    # export UPDATE_ZSH_DAYS=13

    # Uncomment the following line to disable colors in ls.
    # DISABLE_LS_COLORS="true"

    # Uncomment the following line to disable auto-setting terminal title.
    # DISABLE_AUTO_TITLE="true"

    # Uncomment the following line to enable command auto-correction.
    ENABLE_CORRECTION="true"

    # Uncomment the following line to display red dots whilst waiting for completion.
    COMPLETION_WAITING_DOTS="true"

    # Uncomment the following line if you want to disable marking untracked files
    # under VCS as dirty. This makes repository status check for large repositories
    # much, much faster.
    # DISABLE_UNTRACKED_FILES_DIRTY="true"

    # Uncomment the following line if you want to change the command execution time
    # stamp shown in the history command output.
    # The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
    HIST_STAMPS="dd.mm.yyyy"

    # Would you like to use another custom folder than $ZSH/custom?
    # ZSH_CUSTOM=/path/to/new-custom-folder

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # Add wisely, as too many plugins slow down shell startup.
    plugins=(
        # zsh-lazyload
        git
        zsh-syntax-highlighting
        z
        sudo
        # per-directory-history
        python
        zsh-autosuggestions
        # pipenv
        copypath
    )

    source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
fi

function get_xserver() {
    case $TERM in
    xterm)
        XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(')
        # Ane-Pieter Wieringa suggests the following alternative:
        #  I_AM=$(who am i)
        #  SERVER=${I_AM#*(}
        #  SERVER=${SERVER%*)}
        XSERVER=${XSERVER%%:*}
        ;;
    aterm | rxvt)
        # Find some code that works here. ...
        ;;
    esac
}

if [ -z ${DISPLAY:=""} ]; then
    get_xserver
    if [[ -z ${XSERVER} || ${XSERVER} == $(hostname) || ${XSERVER} == "unix" ]]; then
        DISPLAY=":0.0" # Display on local host.
    else
        DISPLAY=${XSERVER}:0.0 # Display on remote host.
    fi
fi

export DISPLAY

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.

# Normal Colors
Black='\e[0;30m'  # Black
Red='\e[0;31m'    # Red
Green='\e[0;32m'  # Green
Yellow='\e[0;33m' # Yellow
Blue='\e[0;34m'   # Blue
Purple='\e[0;35m' # Purple
Cyan='\e[0;36m'   # Cyan
White='\e[0;37m'  # White

# Bold
BBlack='\e[1;30m'  # Black
BRed='\e[1;31m'    # Red
BGreen='\e[1;32m'  # Green
BYellow='\e[1;33m' # Yellow
BBlue='\e[1;34m'   # Blue
BPurple='\e[1;35m' # Purple
BCyan='\e[1;36m'   # Cyan
BWhite='\e[1;37m'  # White

# Background
On_Black='\e[40m'  # Black
On_Red='\e[41m'    # Red
On_Green='\e[42m'  # Green
On_Yellow='\e[43m' # Yellow
On_Blue='\e[44m'   # Blue
On_Purple='\e[45m' # Purple
On_Cyan='\e[46m'   # Cyan
On_White='\e[47m'  # White

NC="\e[m" # Color Reset

ALERT=${BWhite}${On_Red} # Bold White on red background

NCPU=$(grep -c 'processor' /proc/cpuinfo) # Number of CPUs
SLOAD=$((100 * ${NCPU}))                  # Small load
MLOAD=$((200 * ${NCPU}))                  # Medium load
XLOAD=$((400 * ${NCPU}))                  # Xlarge load

#============================================================
#
#  ALIASES AND FUNCTIONS
#
#  Arguably, some functions defined here are quite big.
#  If you want to make this file smaller, these functions can
#+ be converted into scripts and removed from here.
#
#============================================================

#-------------------
# Personnal Aliases
#-------------------
alias weather='curl "wttr.in/sao+paulo?m"'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'
alias h='history'
alias which='type -a'
alias ..='cd ..'
# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias du='du -kh' # Makes a more readable output.
alias df='df -kTh'
# Docker alias
alias dps='docker ps'
alias dim='docker images'
alias dvol='docker volume'
alias dpull='docker pull'
alias dexec='docker exec -it'
alias drmid='docker rmi $(docker images -f 'dangling=true' -q)' # Removes all <none> images
alias dcom='docker-compose'
alias dup='docker-compose up'
alias ddown='docker-compose down'
alias ports='lsof -i -P -n | grep LISTEN'

function de() {
    docker exec -it $1 ${2-bash} ${@:3}
}
function dce() {
    docker-compose exec $1 ${2-bash} ${@:3}
}
function cup() {
    eval './start_${1-dev}.sh ${2-up}'
}
# Kubernetes alias
alias kctl='kubectl'
alias kget='kubectl get'
alias kapply='kubectl apply -f'
alias kdp='kubectl describe pods'
# alias klogs='kubectl logs'
function klogs() {
    kubectl logs $(kubectl get pods | grep ${1} | awk '{print $1;exit}')
}
function ke() {
    kubectl exec -it $1 ${2-bash} ${@:3}
}
alias k=kubectl
alias pods='kubectl get pods'
alias svc='kubectl get svc'
alias kall='kubectl get deploy,pods,svc'

#Github alias
alias gpr='git pull --rebase '
alias gad='git add '
alias gaa='git add -A'
alias gam='git add -u'
alias gst='git status'
alias gstu='git status -uno'
alias gdf='git diff -w '
alias gcl='git clone '
alias gcp='git cherry-pick '
alias gfa='git fetch --all '
alias gco='git checkout '
alias gba='git branch -a'
alias gcm='git commit -m '
alias gme='git mergetool '
alias gbr='git branch '
# Text Editors
function call_vscode() {
    code .
}
alias c="call_vscode"
# Grep related
alias search="grep -R "
alias g="grep"
alias and="grep"
alias not="grep -v"
alias o='xdg-open '
# System related
alias upgrade="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean"
# if [ /usr/bin/pacman ]; then
# alias upgrade="sudo pacman -Syyu && yay -Sua"
# fi

alias usb='sudo watch -n 0.1 "dmesg | tail -n $((LINES-6))"'

if [ /usr/bin/kubectl ]; then source <(kubectl completion zsh); fi

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias lx='ls -lXB'  #  Sort by extension.
alias lk='ls -lSr'  #  Sort by size, biggest last.
alias lt='ls -ltr'  #  Sort by date, most recent last.
alias lc='ls -ltcr' #  Sort by/show change time,most recent last.
alias lu='ls -ltur' #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'     #  Pipe through 'more'
alias lr='ll -R'        #  Recursive ls.
alias la='ll -A'        #  Show hidden files.
alias tree='tree -Csuh' #  Nice alternative to 'recursive ls' ...

#-------------------------------------------------------------
# Tailoring 'less'
#-------------------------------------------------------------

alias more='less'
export PAGER=less
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
# Use this if lesspipe.sh exists.
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#-------------------------------------------------------------
# Spelling typos - highly personnal and keyboard-dependent :-)
#-------------------------------------------------------------

alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'

#-------------------------------------------------------------
# Make the following commands run in background automatically:
#-------------------------------------------------------------

function naut() {
    command nautilus "$@" >/dev/null &
}

#-------------------------------------------------------------
# Functions
#-------------------------------------------------------------

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' \
    -exec ${2:-file} {} \;; }

#  Find a pattern in a set of files and highlight them:
#+ (needs a recent version of egrep).
function fstr() {
    OPTIND=1
    local mycase=""
    local usage="fstr: find string in files.
    Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt; do
        case "$opt" in
        i) mycase="-i " ;;
        *)
            echo "$usage"
            return
            ;;
        esac
    done
    shift $(($OPTIND - 1))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return
    fi
    find . -type f -name "${2:-*}" -print0 |
        xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more

}

function mr_gitlab() {

    repo_url=$(git remote get-url --all origin | sed 's/\.git//')
    repo_name=$(basename $repo_url)
    current_b=$(git rev-parse --abbrev-ref HEAD)

    url="${repo_url}/-/merge_requests/new?merge_request[source_project_name]=${repo_name}&merge_request[source_branch]=${current_b}&merge_request[target_project_id]=${repo_name}&merge_request[target_branch]=$1"

    google-chrome-stable $url
}

function swap() { # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function extract() { # Handy Extract Program
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2) tar xvjf $1 ;;
        *.tar.gz) tar xvzf $1 ;;
        *.tar.xz) tar xf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xvf $1 ;;
        *.tbz2) tar xvjf $1 ;;
        *.tgz) tar xvzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz" "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1"; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@"; }

#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"}; }

function killps() {             # kill by process name
    local pid pname sig="-TERM" # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return
    fi
    if [ $# = 2 ]; then sig=$1; fi
    for pid in $(my_ps | awk '!/awk/ && $0~pat { print $1 }' pat=${!#}); do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid)
        if ask "Kill process $pid <$pname> with signal $sig?"; then
            kill $sig $pid
        fi
    done
}

function mydf() { # Pretty-print of 'df' output.
    # Inspired by 'dfc' utility.
    for fs; do

        if [ ! -d $fs ]; then
            echo -e $fs" :No such file or directory"
            continue
        fi

        local info=($(command df -P $fs | awk 'END{ print $2,$3,$5 }'))
        local free=($(command df -Pkh $fs | awk 'END{ print $4 }'))
        local nbstars=$((20 * ${info[1]} / ${info[0]}))
        local out="["
        for ((j = 0; j < 20; j++)); do
            if [ ${j} -lt ${nbstars} ]; then
                out=$out"*"
            else
                out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}

function my_ip() { # Get IP adress on ethernet.
    MY_IP=$(/bin/ip a | awk '/inet/ { print $2 } ' |
        sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii() { # Get current host related info.
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC "
    uname -a
    echo -e "\n${BRed}Users logged on:$NC "
    w -hs |
        cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC "
    date
    echo -e "\n${BRed}Machine stats :$NC "
    uptime
    echo -e "\n${BRed}Memory stats :$NC "
    free
    echo -e "\n${BRed}Diskspace :$NC "
    df -h
    echo -e "\n${BRed}Local IP Address :$NC"
    my_ip
    echo -e "\n${BRed}Open connections :$NC "
    netstat -pan --inet
    echo
}

#-------------------------------------------------------------
# Misc utilities:
#-------------------------------------------------------------

function exports() {
    while read LINE; do
        echo "%s\n" "$line"
    done <"$1"
}

function repeat() { # Repeat n times command.
    local i max
    max=$1
    shift
    for ((i = 1; i <= max; i++)); do # --> C-like syntax
        eval "$@"
    done
}

function s() {
    ssh-copy-id $1
    scp /etc/bash.bashrc $1:/tmp/.bashrc_temp
    ssh -t $1 $2 $3 "bash --rcfile /tmp/.bashrc_temp"
}

function gbrkeep() {
    git branch | grep -v "$1" | xargs git branch -D
}
function gps() {
    git config --global credential.helper cache
    git config --global credential.helper 'cache --timeout=604800'
    git push $1 $2 $3 $4 $5 $6
}
function gpu() {
    git config --global credential.helper cache
    git config --global credential.helper 'cache --timeout=604800'
    git pull $1 $2 $3 $4 $5 $6
}

function ssu() {
    su $1 $2 $3 $4 $5-c "bash --rcfile /tmp/.bashrc_temp"
}

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# WELCOME SCREEN
########################################################

clear

weekday=$(date "+%-u")
msg=""
if [ $weekday -eq 1 ]; then
    msg="Hardcore day to work. I bet."
fi
if [ $weekday -eq 2 ]; then
    msg=""
fi
if [ $weekday -eq 3 ]; then
    msg="Finish your job and go drink beer to celebrate the midweek."
fi
if [ $weekday -eq 4 ]; then
    msg=""
fi
if [ $weekday -eq 5 ]; then
    msg="Today is the badness day. Go to run update/delete without where! Install Windows on a Mac Computer.."
fi
if [ $weekday -eq 6 ]; then
    msg="Are you working today brah?"
fi
if [ $weekday -eq 7 ]; then
    msg="You still working brah?"
fi

echo -ne "${White}" "Hello $USER, " $msg
echo -ne "${Purple}" "Today is "
date
echo -e "${Green}"
cal -3
echo -ne "${Cyan}"

source ~/.profile
