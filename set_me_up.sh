echo "Cloning public oh-my-zsh repository..."
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# if profile was specified on the command line
if [ -n "$2" ]; then
  profile=$2
else
  echo "Available profiles:"
  for x in `ls ~/.dotfiles/profiles/`; do echo $x; done
  read -p "Please choose a profile." profile
fi

if [ ! -d ~/.dotfiles/profiles/$profile/ ]; then
  echo "~/.dotfiles/profiles/$profile/ is not a directory, quitting..."
  exit 1
fi

if [ ! -a ~/.dotfiles/profiles/$profile/.zshrc ]; then
  echo "~/.dotfiles/profiles/$profile/.zshrc not found, quitting..."
fi
echo "Copying ~/.dotfiles/profiles/$profile/.zshrc to home directory"
cp ~/.dotfiles/profiles/$profile/.zshrc ~/.zshrc

echo "Changing shell to /bin/zsh"
chsh -s /bin/zsh
