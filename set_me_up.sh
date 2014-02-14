if [ ! -d ~/.dotfiles/profiles/$profile/ ]; then
  echo "Cloning public oh-my-zsh repository..."
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
  echo "oh-my-zsh repository already exists, pulling latest changes..."
  pushd ~/.oh-my-zsh &> /dev/null
  git pull
  popd ~/.oh-my-zsh &> /dev/null
fi

# if profile was specified on the command line
if [ -n "$1" ]; then
  profile=$1
else
  echo "Available profiles:"
  for x in `ls ~/.dotfiles/profiles/`; do echo "  $x"; done
  read -p "Please choose a profile: " profile
fi

if [ ! -d ~/.dotfiles/profiles/$profile/ ]; then
  echo "~/.dotfiles/profiles/$profile/ is not a directory, quitting..."
  exit 1
fi

if [ ! -a ~/.dotfiles/profiles/$profile/.zshrc ]; then
  echo "~/.dotfiles/profiles/$profile/.zshrc not found, quitting..."
fi

if [ -a ~/.zshrc ]; then
  timestamp=$(date +%s)
  mv ~/.zshrc ~/.zshrc.backup_$timestamp
  echo "~/.zshrc already exists, created backup: ~/.zshrc.backup_$timestamp"
  echo "To restore, run the following:"
  echo "  mv ~/.zshrc.backup_$timestamp ~/.zshrc"
fi 

echo "Copying ~/.dotfiles/profiles/$profile/.zshrc to home directory"
cp ~/.dotfiles/profiles/$profile/.zshrc ~/.zshrc

if [ ! -a ~/.dotfiles/profiles/$profile/tmux.conf ]; then
  echo "~/.dotfiles/profiles/$profile/tmux.conf not found, quitting..."
fi

if [ -a ~/tmux.conf ]; then
  timestamp=$(date +%s)
  mv ~/tmux.conf ~/tmux.conf.backup_$timestamp
  echo "~/tmux.conf already exists, created backup: ~/tmux.conf.backup"
  echo "To restore, run the following:"
  echo "  mv ~/tmux_$timestamp.conf.backup ~/tmux.conf"
fi 

echo "Copying ~/.dotfiles/profiles/$profile/tmux.conf to home directory"
cp ~/.dotfiles/profiles/$profile/tmux.conf ~/tmux.conf

if [ -n $ZSH_NAME ]; then
  echo "Changing shell to /bin/zsh"
  chsh -s /bin/zsh
else
  echo "\$ZSH_NAME is already set, assuming that default shell is already zsh"
fi
