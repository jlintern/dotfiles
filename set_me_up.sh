echo "Cloning public oh-my-zsh repository..."
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

echo "Cloning private dotfiles repository..."
git clone git://github.com/jlintern/dotfiles.git ~/.dotfiles

# if profile was specified on the command line
if [ -n "$1" ]; then
  profile=$1
else
  echo "Available profiles:"
  for x in `ls ~/.dotfiles/profiles/`; do echo $x; done
  read -p "Please choose a profile." profile
fi

if [ ! -d ~/.dotfiles/$profile/ ]
  echo "~/.dotfiles/$profile/ is not a directory, quitting..."
  exit 1
fi

if [ ! -a ~/.dotfiles/$profile/.zshrc ]
  echo "~/.dotfiles/$profile/.zshrc not found, quitting..."
fi
echo "Copying ~/.dotfiles/$profile/.zshrc to home directory"
cp ~/.dotfiles/$profile/.zshrc ~/.zshrc

echo "Changing shell to /bin/zsh"
chsh -s /bin/zsh
