#!/bin/bash

# this file is copied into the user's home directory by set_me_up.sh

### dotfiles_substitution: define_repo_dir ###
pushd $repo_dir
git commit -a
git pull --rebase
git push
./set_me_up.sh
popd
