" based on http://github.com/jferris/config_files/blob/master/vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=100    " keep 50 lines of command line history
set showcmd       " display incomplete commands
set incsearch     " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" Make Y consistent with C and D
nnoremap Y y$

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Use soft wrapping, and adjust mappings for edit keys
set wrap linebreak textwidth=0 showbreak=\ \ \ …\  cpoptions+=n
map j gj
map k gk
map <Up> gk
map <Down> gj

" Pathogen intialization
filetype off
call pathogen#runtime_append_all_bundles()

" Custom status line using to show git branch info, has ruler set
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%{rvm#statusline()}\ %-14.(%c%V,%l/%L%)\ %P\ %y

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  " Makefiles require hard tabs
  autocmd FileType make setlocal noexpandtab

  " Highlight the current line the cursor is on, only for the active window
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    " autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim), or it is a commit message.
    autocmd BufReadPost *
          \ if &filetype !~ 'commit\c' |
          \   if line("'\"") > 1 && line("'\"") <= line("$") |
          \     exe "normal! g`\"" |
          \     normal! zz |
          \   endif |
          \ endif

    " Automatically load .vimrc source when saved
    autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" if has("folding")
"   set foldenable
"   set foldmethod=syntax
"   set foldlevel=1
"   set foldnestmax=2
"   set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
" endif

" Softtabs, 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = ","

" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel
map <Leader>c :Rcontroller
map <Leader>v :Rview
map <Leader>u :Runittest
map <Leader>f :Rfunctionaltest
map <Leader>tm :RTmodel
map <Leader>tc :RTcontroller
map <Leader>tv :RTview
map <Leader>tu :RTunittest
map <Leader>tf :RTfunctionaltest
map <Leader>sm :RSmodel
map <Leader>sc :RScontroller
map <Leader>sv :RSview
map <Leader>su :RSunittest
map <Leader>sf :RSfunctionaltest

" Toggle spell checking
map <Leader>s :set spell!<CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Move lines up and down
map <C-J> :m +1 <CR>
map <C-K> :m -2 <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Maps autocomplete to tab
" imap <Tab> <C-N>

imap <C-L> <Space>=><Space>

" Display extra whitespace
set list listchars=tab:▸\ ,eol:¬,precedes:<,extends:>

" Toggle showing whitespace
nmap <Leader>z :set list!<CR>

" Switch on highlighting the last used search pattern.
" Also let this be toggleable
if (&t_Co > 2 || has("gui_running"))
  set hlsearch
  map <Leader>h :set hlsearch!<CR>
endif

" Edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ack instead of Grep when available
" if executable("ack")
"   set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
" endif

" Color scheme
set background=dark
colorscheme ir_black

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set smartcase

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;

" Open URL
command! -bar -nargs=1 OpenURL :!open <args>
function! OpenURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
    exec "!open \"" . s:uri . "\""
  else
    echo "No URI found in line."
  endif
endfunction
map <Leader>w :call OpenURL()<CR>

" Paste mode to turn off autoindention
set pastetoggle=<F2>

" Removes trailing spaces
function! TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

map <Leader>x :call TrimWhiteSpace()<CR>

" Make vim more accepting of hidden buffer
set hidden

" Mappings for fugitive
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>ga :Gwrite<CR>
nmap <Leader>gl :Glog<CR>
nmap <Leader>gd :Gdiff<CR>

" Swap and backup files suck for the most part
set nobackup nowritebackup noswapfile

" Don't continue comments when doing o/O
set formatoptions-=o

" Find in NerdTree!
nnoremap <silent> <C-f> :NERDTreeFind<CR>

" BufExplorer's <Leader>be is too much
nnoremap <Leader>b :BufExplorer<CR>

" Make navigating windows nicer
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Command-T configuration
let g:CommandTMaxHeight=10

" Mark syntax errors with :signs
let g:syntastic_enable_signs=1

" snipmate setup
try
  source ~/.vim/snippets/support_functions.vim
catch
  source ~/vimfiles/snippets/support_functions.vim
endtry
autocmd vimenter * call s:SetupSnippets()
function! s:SetupSnippets()
  "if we're in a rails env then read in the rails snippets
  if filereadable("./config/environment.rb")
    call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
    call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
  endif

  call ExtractSnips("~/.vim/snippets/html", "eruby")
  call ExtractSnips("~/.vim/snippets/html", "xhtml")
  call ExtractSnips("~/.vim/snippets/html", "php")
endfunction


if has("gui_running")
  set t_Co=256
  set guioptions-=T

  if has("gui_mac") || has("gui_macvim")
    set guifont=Akkurat-Mono:h12
  endif

  if has("gui_gnome")
    set term=gnome-256color
    set guifont=Inconsolata\ Medium\ 12
  endif

  if has("gui_win32") || has("gui_win32s")
    set guifont=Consolas:h12
    set enc=utf-8
  endif
endif


