if [ ! -d ~/.dotfiles/profiles/$profile/ ]; then
  echo "Cloning public oh-my-zsh repository..."
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
  echo "oh-my-zsh repository already exists, pulling latest changes..."
  pushd ~/.oh-my-zsh &> /dev/null
  git pull
  popd ~/.oh-my-zsh &> /dev/null
fi

echo
# determine what profile to use

# if profile was specified on the command line
if [ -n "$1" ]; then
  profile=$1
else
  if [ -a ~/.dotfiles.profile ]; then
    profile=$(head -1 ~/.dotfiles.profile)
    echo "Found ~/.dotfiles.profile, using default profile '$profile'"
  else
    echo "No default profile found, none specified on command line. Here are the available profiles:"
    for x in `ls ~/.dotfiles/profiles/`; do echo "  $x"; done
    read -p "Please choose a profile: " profile
  fi
fi

if [ ! -d ~/.dotfiles/profiles/$profile/ ]; then
  echo "~/.dotfiles/profiles/$profile/ is not a directory, quitting..."
  exit 1
fi

echo 
# save profile as default for next time

echo $profile > ~/.dotfiles.profile

echo
# .zshrc

if [ -a ~/.dotfiles/profiles/$profile/.zshrc ]; then
  if [ -a ~/.zshrc ]; then
    timestamp=$(date +%s)
    mv ~/.zshrc ~/.zshrc.backup_$timestamp
    echo "~/.zshrc already exists, created backup: ~/.zshrc.backup_$timestamp"
    echo "To restore, run the following:"
    echo "  mv ~/.zshrc.backup_$timestamp ~/.zshrc"
  fi 

  echo "Copying ~/.dotfiles/profiles/$profile/.zshrc to home directory"
  cp ~/.dotfiles/profiles/$profile/.zshrc ~/.zshrc
fi

echo
# tmux.conf

#TODO: refactor into function, combined with block above
if [ ! -a ~/.dotfiles/profiles/$profile/tmux.conf ]; then
  if [ -a ~/tmux.conf ]; then
    timestamp=$(date +%s)
    mv ~/tmux.conf ~/tmux.conf.backup_$timestamp
    echo "~/tmux.conf already exists, created backup: ~/tmux.conf.backup_$timestamp"
    echo "To restore, run the following:"
    echo "  mv ~/tmux.conf.backup_$timestamp ~/tmux.conf"
  fi 

  echo "Copying ~/.dotfiles/profiles/$profile/tmux.conf to home directory"
  cp ~/.dotfiles/profiles/$profile/tmux.conf ~/tmux.conf
fi

echo
# changing shell if necessary

if [ $SHELL == '/bin/zsh' ]; then
  echo "\$SHELL is already '/bin/zsh', not calling chsh..."
else
  echo "\$SHELL is currently $SHELL, running chsh -s /bin/zsh"
  chsh -s /bin/zsh
fi

echo
# print success message

echo "Setup completed successfully"

