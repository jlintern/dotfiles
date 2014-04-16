echo "0 path is $PATH"
bash $HOME/bin/pull_dotfiles.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
