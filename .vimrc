"molokai.vim
set spell "check spell
set spelllang=en,cjk  "out japanese with set spell
let g:rehash256 = 1

"aモードの時に、カーソルを戻さない
inoremap <silent> <Esc> <Esc>`^
set showmode

"構文カラー
syntax enable

"undotree setting
if has('persistent_undo')
let &undodir = expand('~/.vim/undo_history')
set undofile
endif



"---------------------------------------------------------------------------------
"augroup {{{

augroup vimrc-auto-mkdir  "ディレクトリがないときに自動でディレクトリを作成してくれる
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
  function! s:auto_mkdir(dir)  
    if !isdirectory(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  
augroup END  

augroup MyVimrc
  autocmd QuickFixCmdPost [^l]*  cwindow "[^l]* とすると、l 以外の文字で始まる任意のコマンドを実行
  autocmd QuickFixCmdPost l*  lwindow
augroup END

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
  autocmd FileType vim setl tabstop=4 softtabstop=4 shiftwidth=4  expandtab
augroup END
" }}}



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
let s:has_neobundle = isdirectory($HOME . '/.vim/bundle/neobundle.vim')
let s:need_neobundle = 1 "neobundleをinstallする必要があるときは1、そうじゃないと0
if !s:has_neobundle && s:need_neobundle
    echo "execute :NeoBundleInstall"
endif

"NeoBundle setting
set nocompatible " Be iMproved

filetype off " Required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

filetype plugin indent on " Required!
  
  
  
"-----------------------------------------------------------------------------
"Instaled NeoBundle Plugin {{{
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'basyura/bitly.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'mbbill/undotree'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neocomplete.vim'
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
NeoBundle 'agatan/vim-vlack'
NeoBundle 'mattn/vim-metarw-redmine'
NeoBundle 'kana/vim-metarw'


NeoBundleLazy 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

NeoBundleLazy 'vim-scripts/TwitVim',{
\ 'autoload' : {
\     'commands' : [ "FriendsTwitter","RepliesTwitter","PosttoTwitter" ]
\    },
\ }

NeoBundleLazy 'thinca/vim-quickrun',{
\ 'autoload' : {
\     'commands' : [ "QuickRun" ]
\    },
\ }

NeoBundle 'Shougo/vimshell.vim',{
\ 'autoload' : {
\     'commands' : [ "VimShell" ]
\    },
\ }
" }}}

 
" ------------------------------------------------------------------------------------
"  NeoBundle setting{{{

" NeoBundle 'thinca/vim-quickrun' setting
let s:bundle = neobundle#get("vim-quickrun")
function! s:bundle.hooks.on_source(bundle)
  let g:quickrun_config={'*':{'split':''}}
  set splitbelow
endfunction
unlet s:bundle
  
  

"NERDTree setting
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


"twitter
let s:bundle = neobundle#get("TwitVim")
function! s:bundle.hooks.on_source(bundle)
  let twitvim_force_ssl = 1 
  let twitvim_count = 40
endfunction
unlet s:bundle


"slack setting and token switch
let g:slaq_token = "token" "vim-jp


"redmine config
let g:metarw_redmine_server = 'site'
let g:metarw_redmine_apikey = 'key'

"VimShell 
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
"}}}


"-----------------------------------------------------------------------------
"maping{{{
  nnoremap q :QuickRun<cr> "qでquickrun

  nmap gx <Plug>(openbrowser-smart-search) "url上でgxを押すとブラウザで展開
  nmap R <Leader>r
"}}}





set secure

