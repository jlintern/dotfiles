#!/bin/zsh

#if host was specified on the command line
if [ -n "$1" ]; then
  host=$1
else
  read -p "Please specify a host: " host
fi

echo "Cloning private dotfiles repository..."
ssh -t $host "git clone git://github.com/jlintern/dotfiles.git ~/.dotfiles"
ssh -t $host "bash ~/.dotfiles/set_me_up.sh"
