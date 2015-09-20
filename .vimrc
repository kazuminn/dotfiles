"molokai.vim
set spell "check spell
set spelllang=en,cjk  "out japanese with set spell

set mouse=a " enable mouse in all modes
set incsearch " show matches when typing the search pattern

set nofixendofline
"fold setting
set foldmethod=marker "{{{がmarker  zj/zkで移動
set foldlevel=2

"function! s:get_sid()
"  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeget_sid$')
"endfunction
"let s:sid = s:get_sid()
"delfunction s:get_sid

" Show invisible characters.
set list listchars=tab:^\ ,trail:_,extends:>,precedes:<
"set invlist
"set list  " show non-normal spaces, tabs etc.

set noshowmatch " 括弧の対応をハイライト
set shortmess+=I " 起動時のメッセージを表示しない
"vim diff setting
set diffopt=vertical

"整形
command! Format call s:execute_keep_view('call s:format()')

function! s:format()
  if &filetype ==# 'cs'
    OmniSharpCodeFormat
  elseif &filetype ==# 'c'
    ClangFormat
  elseif &filetype ==# 'cpp'
    ClangFormat
  elseif &filetype ==# 'go'
    call s:filter_current('goimports %s', 0)
  elseif &filetype ==# 'javascript' && executable('js-beautify')
    call s:filter_current('js-beautify %s', 0)
  elseif &filetype ==# 'xml'
    let $XMLLINT_INDENT = '    '
    if !s:filter_current('xmllint --format --encode ' . &encoding . ' %s', 1)
      execute 'silent! %substitute/>\s*</>\r</g | normal! gg=G'
    endif
  elseif &filetype ==# 'json'
    call s:filter_current('jq . %s', 0)
  else
    echomsg 'Format: Not supported:' &filetype
  endif
endfunction

function! s:execute_keep_view(expr)
  let wininfo = winsaveview()
  execute a:expr
  call winrestview(wininfo)
endfunction

"区切り文字に:を追加
"構文カラー"{{{"}}}
syntax enable

"undotree setting
if has('persistent_undo')
let &undodir = expand('~/.vim/undo_history')
set undofile
endif

"よくわかんないけどtermialとのconnectionが早くなる
set ttyfast

"deleteキー
set bs+=start "insert modeになる前の文字もdeleteキーで消せるようにする。

"カーソル
if has('xim') || has('multi_byte_ime')
  highlight CursorIM guifg=Black guibg=Red
endif

"reopen encodeing file alias
function! ConvertFileEncode(encoding, ...)
    exec('setl fileencoding='.a:encoding)
    exec('setl fileformat='.get(a:, 2, 'unix'))
endfunction


command! Utf8      call ConvertFileEncode('utf-8')
command! Cp932     call ConvertFileEncode('cp932')
command! Sjis      Cp932
command! Utf16b    call ConvertFileEncode('utf-16')
command! Utf16l    call ConvertFileEncode('utf-16le')
command! Iso2022jp call ConvertFileEncode('iso-2022-jp')
command! Jis       Iso2022jp
command! Eucjp     call ConvertFileEncode('euc-jp')

"ref pugin
let g:ref_refe_cmd = $HOME.'/.rbenv/shims/refe' "refeコマンドのパス URL:http://qiita.com/masa2sei/items/85a2c2cc3721c79a5322

"クラッシュした時に大丈夫なように
if has('unix')
    set nofsync
    set swapsync=
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
augroup ALL
  autocmd!
  autocmd FileType c  setl tabstop=4 softtabstop=4 shiftwidth=4 expandtab
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

call neobundle#begin(expand('~/.vim/bundle/'))


" guioptions {{{
" メニューを読み込まない
set guioptions+=M

" ツールバー削除
set guioptions-=T

" メニューバー削除
set guioptions-=m

" スクロールバー削除
set guioptions-=r
set guioptions-=l
set guioptions-=R
set guioptions-=L

" テキストベースタブ
set guioptions-=e
" }}}

call neobundle#load_cache()  " キャッシュの読込み
NeoBundleFetch 'Shougo/neobundle.vim'

"-----------------------------------------------------------------------------
"Instaled NeoBundle Plugin {{{
if neobundle#load_cache()
    NeoBundle 'Shougo/neobundle.vim'
    NeoBundle 'vim-jp/vim-go-extra' "https://github.com/vim-jp/vim-go-extra
    NeoBundle 'rking/ag.vim'
    NeoBundle 'mattn/webapi-vim'
    NeoBundle 'tyru/open-browser.vim'
    NeoBundle 'h1mesuke/unite-outline'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'tmhedberg/matchit'
    NeoBundle 'Yggdroot/indentLine'
    NeoBundle 'mbbill/undotree'
    "NeoBundle 'scrooloose/nerdtree'
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundle 'supermomonga/shaberu.vim'
    NeoBundle 'tpope/vim-surround' "extends pagin text-object   URL:http://vimblog.hatenablog.com/entry/vim_plugin_surround_vim
    NeoBundle 'terryma/vim-multiple-cursors'
    NeoBundle 'plasticboy/vim-markdown'
    NeoBundle 'kannokanno/previm'
    NeoBundle 'tyru/open-browser.vim'
    NeoBundle 'thinca/vim-ref'
    NeoBundle 'ebc-2in2crc/vim-ref-jvmis'
    NeoBundle 'pekepeke/ref-javadoc'
    NeoBundle 'mattn/webapi-vim'
    NeoBundle 'vitalk/vim-simple-todo'
    NeoBundle 'vim-scripts/gtags.vim'
    NeoBundle 'kazuminn/latex_template.vim'
    NeoBundle 'agatan/vim-vlack'
    NeoBundle 'mattn/vim-metarw-redmine'
    NeoBundle 'kana/vim-metarw'
    NeoBundle 'kazuminn/gunosy.vim'
    NeoBundle 'haya14busa/incsearch-fuzzy.vim' "search.
    NeoBundle 'haya14busa/incsearch.vim' "search.
    NeoBundle 'itchyny/lightline.vim'  "statusline hightlight URL:https://github.com/itchyny/lightline.vim
    NeoBundle 'Lokaltog/vim-easymotion' "爆速カーソル移動　URL:http://haya14busa.com/mastering-vim-easymotion/
    NeoBundle 'bronson/vim-trailing-whitespace'
    NeoBundle 'sjl/gundo.vim' "watch undo tree
    NeoBundle 'mattn/gist-vim' "gist　楽ニー
    NeoBundle 'Shougo/neosnippet.vim'
    NeoBundle 'Shougo/neocomplcache'
    NeoBundle 'Shougo/neosnippet-snippets'
    NeoBundleSaveCache

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
endif







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
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


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

fixdel
"VimShell
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
"
"
let g:lightline = {
\ 'colorscheme': 'default',
\ }
set laststatus=2
"
"
"unite
let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
nnoremap <space><space> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)


"ag
nmap ° :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag


"vim plugin test http://qiita.com/c0hama/items/4ab505ddebdcfd842e25
command! -bang -nargs=* PluginTest call PluginTest()
function! PluginTest()
  execute '!vim -u NONE -i NONE -N --cmd "set rtp+=' . getcwd() . '"'
endfunction
"
"
"light.vim
command! -bar LightlineUpdate    call lightline#init()|
  \ call lightline#colorscheme()|
  \ call lightline#update()

let g:lightline.component = {}
let g:lightline.component.dir = '%.35(%{expand("%:h:s?\\S$?\\0/?")}%)'
let g:lightline.active = {}
let g:lightline.active.left = [['mode', 'paste'], ['dir'],['readonly', 'filename', 'modified']]
"
"
"neosnippet.vim setting
let g:neocomplete#enable_at_startup = 1
"
" 自分用 snippet ファイルの場所
let s:my_snippet = '~/dotfiles/snippet/'
let g:neosnippet#snippets_directory = s:my_snippet

"}}}

"
call neobundle#end()
filetype plugin indent on " Required!

"-----------------------------------------------------------------------------
"maping{{{
  nnoremap q :QuickRun<cr> "qでquickrun

  nmap gz <Plug>(openbrowser-smart-search) "url上でgxを押すとブラウザで展開
  nmap R <Leader>r
  nmap  z/ <Plug>(incsearch-fuzzy-/)
  nnoremap sh <C-w>h
  nnoremap sj <C-w>j
  nnoremap sk <C-w>k
  nnoremap sl <C-w>l
  nnoremap sn <C-w>n

  map <C-g> :Gtags
  "関数表示
  map <C-h> :Gtags -f %<CR>
  map <C-j> :GtagsCursor<CR> "自動的にその関数が定義されている箇所（別ファイルであっても）に移動してくれます。
  map <C-n> :cn<CR>
  map <C-e> :cp<CR>
  noremap <C-p> gt
  noremap <C-n> gT
  imap <C-h>  <BS>
  "neosnippet.vim
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  "" Display lines up/down (consecutive motions are quicker)
  "wrapされた行でも真下に移動できる
  nnoremap j gj
  nnoremap k gk

  set pastetoggle=<F10> "<F10> is :set paste or :set :set nopaste
  nmap s <Plug>(easymotion-s2)
  "easy-motion.use s{char}{char}{label}. URL http://haya14busa.com/mastering-vim-easymotion/
"}}}


"set iskeyword+=:
"hoge::hogeモジュールとか*で飛べるようになるよ。でも、影響範囲が大きいのでsetlとかしよう。

set secure
set title
