"molokai.vim
set spell "check spell
set spelllang=en,cjk  "out japanese with set spell
let g:rehash256 = 1

inoremap <silent> <Esc> <Esc>`^
set showmode

"構文カラー
syntax enable


"for All
augroup Myvimrc
  autocmd!
augroup END

"for Golang
augroup Golang
  au BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4
augroup END

"for Ruby
augroup Ruby
  autocmd!
  autocmd FileType ruby  setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
augroup END

"for Python
augroup Python
  autocmd!
  autocmd FileType python setl tabstop=4 softtabstop=4 shiftwidth=4  expandtab
  autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
augroup END

"for Vim Script
augroup Vim 
  autocmd!
  autocmd FileType vim setl tabstop=2 softtabstop=2 shiftwidth=2  expandtab
augroup END




"ステータスカラー
highlight statusline term=NONE cterm=NONE guifg=red ctermfg=yellow ctermbg=red


"行番号
set number



"markdown setting
au BufRead,BufNewFile *.md set filetype=markdown



"なんだろこれ
set nocompatible
filetype plugin indent on

"NeoBundle 'neocompoete' setting
let g:neocomplete#enable_at_startup = 1

  " Installation check.
"if neobundle#exists_not_installed_bundles()
"echomsg 'Not installed bundles : ' .
"\ string(neobundle#get_not_installed_bundle_names())
"echomsg 'Please execute ":NeoBundleInstall" command.'
"finish
"endif

"NeoBundle setting
set nocompatible " Be iMproved

filetype off " Required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

filetype plugin indent on " Required!
  
  
  
  
  "NeoBundle plugin install
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mbbill/undotree'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\ 'windows' : 'make -f make_mingw32.mak',
\ 'cygwin' : 'make -f make_cygwin.mak',
\ 'mac' : 'make -f make_mac.mak',
\ 'unix' : 'make -f make_unix.mak',
\ },
\ }
NeoBundle 'supermomonga/shaberu.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'ebc-2in2crc/vim-ref-jvmis'
NeoBundle 'pekepeke/ref-javadoc'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'vitalk/vim-simple-todo'
NeoBundle '5t111111/alt-gtags.vim'
NeoBundle 'kazuminn/latex_template.vim'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }


 
" NeoBundle 'thinca/vim-quickrun' setting
let g:quickrun_config={'*':{'split':''}}
set splitbelow
  
  
  
"NeoBundle quickrun setting
set splitbelow
  
  
  
  
"NeoBundle undotree setting
if has('persistent_undo')
let &undodir = expand('~/.vim/undo_history')
set undofile
endif


"NERDTree setting
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  


"##############################################################################
" mapping
"##############################################################################
  nnoremap q :QuickRun<cr>





set secure

