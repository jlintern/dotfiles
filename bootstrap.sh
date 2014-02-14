#if host was specified on the command line
if [ -n "$2" ]; then
  host=$2
else
  read -p "Please specify a host: " host
fi

echo "Cloning private dotfiles repository..."
ssh $host "git clone git://github.com/jlintern/dotfiles.git ~/.dotfiles"
ssh $host "bash ~/.dotfiles/set_me_up.sh"
