#!/bin/bash

# inspired by https://github.com/benjie/dotfiles

ln -s $PWD/ssh_config            ~/.ssh/config
ln -s $PWD/vimrc                 ~/.vimrc
ln -s $PWD/bashrc                ~/.bashrc
ln -s $PWD/gitconfig             ~/.gitconfig
ln -s $PWD/ctags                 ~/.ctags
ln -s $PWD/perltidyrc            ~/.perltidyrc
ln -s $PWD/dir_colors.solarized  ~/.dir_colors.solarized

#vim plugins
mkdir -p ~/.vim/bundle
git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
git clone https://github.com/kchmck/vim-coffee-script.git       ~/.vim/bundle/vim-coffee-script
git clone git://github.com/digitaltoad/vim-jade.git             ~/.vim/bundle/vim-jade
git clone https://github.com/plasticboy/vim-markdown.git        ~/.vim/bundle/vim-markdown
git clone https://github.com/will133/vim-dirdiff.git            ~/.vim/bundle/vim-dirdiff
mkdir -p ~/.vim/plugin
ln -s $PWD/dotfiles/vim_tagbar ~/.vim/plugin/tagbar.vim
mkdir -p ~/.vim/autoload
ln -s $PWD/vim_pathogen        ~/.vim/autoload/pathogen.vim
ln -s $PWD/vim_tagbar_autoload ~/.vim/autoload/tagbar.vim
ln -s $PWD/vim_tagbar_syntax   ~/.vim/syntax/tagbar.vim 

# liquidprompt - best bash/zsh PS1 I've seen!
git clone https://github.com/nojhan/liquidprompt.git ~/liquidprompt

