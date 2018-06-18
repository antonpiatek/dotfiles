#!/bin/bash

# inspired by https://github.com/benjie/dotfiles

function setLink {
  src="$1"
  target="$2"

  if [ -h "$target" ]
  then
    return;
  fi
  ln -s "$src" "$target"
}

function gitClone {
  giturl="$1"
  target="$2"

  if [ -d "$target" ]
  then
    #TODO: test that it is a git copy?
    return
  fi

  git clone "$giturl" "$target"
}

setLink "$PWD/ssh_config"            ~/.ssh/config
setLink "$PWD/vimrc"                 ~/.vimrc
setLink "$PWD/bashrc"                ~/.bashrc
setLink "$PWD/gitconfig"             ~/.gitconfig
setLink "$PWD/ctags"                 ~/.ctags
setLink "$PWD/perltidyrc"            ~/.perltidyrc
setLink "$PWD/dir_colors.solarized"  ~/.dir_colors.solarized
setLink "$PWD/editorconfig"          ~/.editorconfig

#vim plugins
mkdir -p ~/.vim/bundle
gitClone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
gitClone https://github.com/kchmck/vim-coffee-script.git       ~/.vim/bundle/vim-coffee-script
gitClone git://github.com/digitaltoad/vim-jade.git             ~/.vim/bundle/vim-jade
gitClone https://github.com/plasticboy/vim-markdown.git        ~/.vim/bundle/vim-markdown
gitClone https://github.com/will133/vim-dirdiff.git            ~/.vim/bundle/vim-dirdiff
gitClone https://github.com/majutsushi/tagbar.git              ~/.vim/bundle/tagbar
gitClone https://github.com/kien/ctrlp.vim.git                 ~/.vim/bundle/ctrlp.vim
gitClone https://github.com/editorconfig/editorconfig-vim.git  ~/.vim/bundle/editorconfig-vim
mkdir -p ~/.vim/plugin
setLink "$PWD/dotfiles/vim_tagbar" ~/.vim/plugin/tagbar.vim
mkdir -p ~/.vim/autoload
setLink "$PWD/vim_pathogen"        ~/.vim/autoload/pathogen.vim
setLink "$PWD/vim_tagbar_autoload" ~/.vim/autoload/tagbar.vim
mkdir -p ~/.vim/syntax
setLink "$PWD/vim_tagbar_syntax"   ~/.vim/syntax/tagbar.vim 

# liquidprompt - best bash/zsh PS1 I've seen!
gitClone https://github.com/nojhan/liquidprompt.git ~/liquidprompt

echo all done
