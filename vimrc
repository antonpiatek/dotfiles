execute pathogen#infect()

"don't hide the bloody mouse!
set nomousehide

set showmatch                   
"set how many spaces a tab char is
set tabstop=4

"Tell vi not to replace spaces with tabs
set expandtab
		  
"tab key insterts 2 spaces
set softtabstop=2
" set << and >> to move 2 spaces
set shiftwidth=2 
set shiftround "indent/outdent to nearest tabstop

set matchpairs+=<:> " allow % to bounce between anglest oo

set scrolloff=3

syntax on
set hlsearch
set incsearch


"highlight inside comment strings
"let c_comment_strings=1
""doesnt do anything

" Hightlight tabs - getting annoying... need better colour
hi TAB_CHAR ctermbg=Grey
match TAB_CHAR "\t"

"" Map TagList key to F8
"nnoremap <silent> <F8> :TlistToggle<CR>
"" Open Tag list automatically
"let TlistOpen=1
"let Tlist_Exit_OnlyWindow=1
let g:tagbar_left=1
let g:TagbarOpen=2
nmap <F8> :TagbarToggle<CR> 

" Possible extra options?
set ignorecase " set ignorecsae, except for below:
set smartcase  " case-sensitive if search contains an uppercase character
"set autoindent

set backspace=indent,eol,start " make backspaces delete sensibly

"http://www.vim.org/tips/tip.php?tip_id=369
let b:comment_leader = '# '
au FileType haskell,vhdl,ada            let b:comment_leader = '-- '
au FileType vim                         let b:comment_leader = '" '
au FileType c,cpp,java                  let b:comment_leader = '// '
au FileType sh,make,perl,php,python     let b:comment_leader = '# '
au FileType tex                         let b:comment_leader = '% '
noremap <silent> ,c :<C-B>sil<C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil<C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>
"

" Do this before solarized otherwise we seem to revert to light
call pathogen#infect()
syntax enable
filetype plugin indent on

"colorscheme darkblue
"colorscheme evening
syntax enable
set background=dark
""TODO colorscheme sucks in terminal - either need to detect and change
""something, below doesnt seem to work, or need to do something better
let g:solarized_termcolors=256
 if !has("gui_running")
   if $COLORTERM == 'gnome-terminal'
     set t_Co=256
     let g:solarized_termcolors=256
   endif
 endif
colorscheme solarized

" use ftplugins, particularly for xml.vim
filetype plugin on
"Use autocomplete
set omnifunc=syntaxcomplete#Complete

set modeline

" GUI is running or is about to start.
if has("gui_running")
     " Maximize gvim window.
  set lines=50 columns=200
endif

" Arduino syntax higlighting
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino

" set word wrap on by default
"set wrap linebreak nolist
set wrap linebreak nolist textwidth=0 wrapmargin=0
"set wrap

" set vim markdown folding off
let g:vim_markdown_folding_disabled=1
"

" Set autofoldeing with allowed manual (http://vim.wikia.com/wiki/Folding)
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END


" Set F9 to open/collapse folds
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

au BufRead,BufNewFile *.md set filetype=markdown

" No save backup by .swp, causes oddness in watching for file changes
set nowb
set noswapfile
set noar
