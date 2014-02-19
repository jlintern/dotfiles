#!/bin/bash

if [ -a ~/.dotfiles.config ]; then
  source ~/.dotfiles.config
fi

# if profile was specified on the command line
if [ -n "$1" ]; then
  profile=$1
  if [ -n "$profile" ]; then
    echo "No profile specified. Here are the available profiles:"
    for x in `ls ~/.dotfiles/profiles/`; do echo "  $x"; done
    read -p "Please choose a profile: " profile
  else
    echo "Using profile '$profile' as specified on command line"
  fi
else
  echo "Using profile '$profile' as specified in ~/.dotfiles.config"
fi

if [ ! -d ~/.dotfiles/profiles/$profile/ ]; then
  echo "~/.dotfiles/profiles/$profile/ is not a directory, quitting..."
  exit 1
fi

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
# .zshrc

if [ -a ~/.dotfiles/profiles/$profile/.zshrc ]; then
  echo "Linking ~/.dotfiles/profiles/$profile/.zshrc to home directory"
  ln -f ~/.dotfiles/profiles/$profile/.zshrc ~/.zshrc
fi

echo
# .tmux.conf

#TODO: refactor into function, combined with block above
if [ ! -a ~/.dotfiles/profiles/$profile/.tmux.conf ]; then
  echo "Linking ~/.dotfiles/profiles/$profile/.tmux.conf to home directory"
  ln -f ~/.dotfiles/profiles/$profile/.tmux.conf ~/.tmux.conf
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
#write configuraiton

echo "Saving configuration to ~/.dotfiles.config"
echo "# this file should not be checked into source control" > ~/.dotfiles.config
echo profile=$profile >> ~/.dotfiles.config

echo
#generating convenience scripts

mkdir -p ~/bin

echo "Generating ~/push_dotfiles.sh"
sed "/dotfiles_substitution: define_repo_dir/ c\\
repo_dir=~/.dotfiles\\
" ~/.dotfiles/push_dotfiles.sh > ~/push_dotfiles.sh
chmod +x ~/bin/push_dotfiles.sh

echo "Generating ~/pull_dotfiles.sh"
sed "/dotfiles_substitution: define_repo_dir/ c\\
repo_dir=~/.dotfiles\\
" ~/.dotfiles/push_dotfiles.sh > ~/pull_dotfiles.sh
chmod +x ~/bin/pull_dotfiles.sh

echo
# print success message

echo "Setup completed successfully"
