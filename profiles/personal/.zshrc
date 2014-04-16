# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gentoo"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git screen fasd gradle warp)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# see http://mah.everybody.org/docs/ssh
SSH_ENV="$HOME/.ssh/environment"
function start_agent {
  echo "Initialising new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
}
# Source SSH settings, if applicable
  if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  #ps ${SSH_AGENT_PID} doesn't work under cywgin
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi

function gri {
  if [ "$1" ];
  then
    grep -ri $1 .;
  else
    echo "no argument to gri";
  fi
}
function gril {
  if [ "$1" ];
  then
    grep -ril $1 .;
  else
    echo "no argument to gri";
  fi
}

alias ez="$EDITOR ~/.zshrc; source ~/.zshrc; echo Consider running 'sdf'"
function ca {
  echo "# added by 'ca' on $(date +"%Y-%m-%d %H:%M")\nalias $1=\"$2\"" >> ~/.zshrc
  source ~/.zshrc
  which $1
  echo "Consider running 'sdf'"
}
function gtd {
  grep $1 /Users/jlintern/Dropbox/todo.txt/todo.txt | grep -v "^x "
}
# added by 'ca' on 2014-02-19 23:23
alias sdf="pull_dotfiles.sh; source ~/.zshrc"

# added by 'ca' on 2014-03-13 16:31
alias atd="grep '^x ....-..-..' /Users/jlintern/Dropbox/todo.txt/todo.txt | tee /tmp/archived_todos >> /Users/jlintern/Dropbox/todo.txt/done.txt; sed -i '' '/x ....-..-../d' todo.txt; echo 'Archived the following items:'; cat /tmp/archived_todos"
# added by 'ca' on 2014-03-13 15:58
alias etd="vim /Users/jlintern/Dropbox/todo.txt/todo.txt"
# added by 'ca' on 2014-04-10 16:45
alias gw="./gradlew"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
