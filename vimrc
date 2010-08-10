" based on http://github.com/jferris/config_files/blob/master/vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=100    " keep 50 lines of command line history
set showcmd        " display incomplete commands
set incsearch      " do incremental searching

set cmdheight=3    " Reduce the number of times the hit enter dialog comes up
set shortmess+=a   " Make messages even shorter

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

" Allows moving up by screen lines, not file lines
map j gj
map k gk
map <Up> gk
map <Down> gj

" Diable the stupid bell
set visualbell t_vb=

" Pathogen intialization
filetype off
call pathogen#runtime_append_all_bundles()

" Custom status line using to show git branch info, has ruler set
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%{rvm#statusline()}\ %-14.(%c%V,%l/%L%)\ %P\ %y

" Enable the :Man command
runtime! ftplugin/man.vim

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Set File type to 'text' for files ending in .txt
  augroup TextFiles
    au!
    autocmd BufNewFile,BufRead *.txt setfiletype text
  augroup END

  " Don't show white spaces in man mode
  augroup ManPages
    au!
    autocmd FileType man
          \ setlocal nolist nofoldenable |
          \ map <buffer> q <ESC>:q!<CR>
  augroup END

  " Highlight the current line the cursor is on, only for the active window
  set cursorline
  augroup CursorLine
    au!
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
  augroup END

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim), or it is a commit message.
    autocmd BufReadPost *
         \ if &filetype !~ 'commit\c' |
         \   if line("'\"") > 1 && line("'\"") <= line("$") |
         \     exe "normal! g`\"" |
         \     exe "normal! zvzz" |
         \   endif |
         \ endif

    " Automatically load .vimrc source when saved
    autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END

  augroup GitShortcuts
    au!
    autocmd FileType gitrebase
        \ nnoremap <buffer> p :Pick<CR> |
        \ nnoremap <buffer> s :Squach<CR> |
        \ nnoremap <buffer> e :Edit<CR> |
        \ nnoremap <buffer> r :Reword<CR> |
        \ nnoremap <buffer> f :Fixup<CR> |
        \ nnoremap <buffer> <C-j> :m +1<CR> |
        \ nnoremap <buffer> <C-k> :m -2<CR>
  augroup END
endif " has("autocmd")

set autoindent    " always set autoindenting on
set smartindent

if has("folding")
  set foldenable
  " set foldmethod=syntax
  set foldmethod=indent
  set foldlevel=3 " How far down fold tree to go before folding code on opening file
  set foldlevelstart=3
  set foldnestmax=10
  set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
endif

" Softtabs, 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" \ is the default leader character
let mapleader = ","

" Shortcut to edit .vimrc
noremap <Leader>e :edit $MYVIMRC<CR>

" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

if has("autocmd")
  " Leader shortcuts for Rails commands
  augroup RailsShortcuts
    au!
    autocmd BufEnter *
          \ if exists("b:rails_root") |
          \   let g:base_dir = b:rails_root |
          \ endif

    autocmd User Rails
        \ map <buffer> <Leader>rm :Rmodel |
        \ map <buffer> <Leader>rc :Rcontroller |
        \ map <buffer> <Leader>rv :Rview |
        \ map <buffer> <Leader>ru :Runittest |
        \ map <buffer> <Leader>rf :Rfunctionaltest |
        \ map <buffer> <Leader>rs :Rspec |
        \ map <buffer> <Leader>tm :RTmodel |
        \ map <buffer> <Leader>tc :RTcontroller |
        \ map <buffer> <Leader>tv :RTview |
        \ map <buffer> <Leader>tu :RTunittest |
        \ map <buffer> <Leader>tf :RTfunctionaltest |
        \ map <buffer> <Leader>sm :RSmodel |
        \ map <buffer> <Leader>sc :RScontroller |
        \ map <buffer> <Leader>sv :RSview |
        \ map <buffer> <Leader>su :RSunittest |
        \ map <buffer> <Leader>sf :RSfunctionaltest
  augroup END
endif
" Toggle spell checking
map <Leader>s :set spell!<CR>

" Opens an edit command with the path of the currently edited file filled in
" nnoremap <Leader>e :edit <C-R>=expand("%:p:h") . "/" <CR>

" Opens a vertical window and moves to it
nnoremap <Leader>nv :vsplit<CR><C-w><C-w>

" Opens a horizontal split window and moves to it
nnoremap <Leader>ns :split<CR><C-w><C-w>

" Open a new blank tab
nnoremap <Leader>nt :tabnew<CR>

" Open current window in new tab
nnoremap <Leader>nT <C-w>T

" Move lines up and down
" noremap <M-J> :m +1 <CR>
" noremap <M-K> :m -2 <CR>

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
" nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

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

" Numbers
set number
set numberwidth=5

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t,i

" case only matters with mixed case expressions
set ignorecase
set smartcase

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
function! s:TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

map <Leader>x :call <SID>TrimWhiteSpace()<CR>
map <Leader>xw :call <SID>TrimWhiteSpace()<CR>:w<CR>

" Make vim more accepting of hidden buffer
set hidden

" Mappings for fugitive
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>ga :Gwrite<CR>
nmap <Leader>gl :Glog<CR>
nmap <Leader>gd :Gdiff<CR>

" Store swap files outside of the project direcotry if possible or in
" tmp directory of project
set directory=~/.vim/swap,tmp

" Ask me what to do when quiting or saving fails
set confirm

" Automatically reload files that change on disk
set autoread

" Jump to matching }] briefly when typing
set showmatch

" Don't jump to start of line as side effect, e.g. <<
set nostartofline

" Make ' jump to line, cursor instead of ` since that is used for tmux
nnoremap ' `
nnoremap ` '

" Don't continue comments when doing o/O
set formatoptions-=o

" Command-T configuration
let g:CommandTMaxHeight=10

" Mark syntax errors with :signs
let g:syntastic_enable_signs=1

" snipmate setup
source ~/.vim/snippets/support_functions.vim

function! s:SetupSnippets()
  " Enable rails, mostly ActiveSupport based sippets in normal ruby
  call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
  call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")

  call ExtractSnips("~/.vim/snippets/html", "eruby")
  call ExtractSnips("~/.vim/snippets/html", "xhtml")
  call ExtractSnips("~/.vim/snippets/html", "php")
endfunction

if has("autocmd")
  augroup Snippets
    au!
    autocmd VimEnter * call s:SetupSnippets()
  augroup END

  augroup MoreCompletions
    au!
    autocmd Filetype *
          \ if &omnifunc == "" |
          \   setlocal omnifunc=syntaxcomplete#Complete |
          \ endif
    autocmd FileType ruby,eruby,haml setlocal omnifunc=rubycomplete#Complete
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Ruby functions can have these in thier names
    autocmd FileType eruby,ruby setlocal iskeyword+=!,?

    autocmd FileType vim,ruby setlocal formatoptions-=o
    autocmd FileType nerdtree,taglist setlocal nolist nowrap
    autocmd FileType taglist setlocal foldnestmax=0
  augroup END
endif

" Ruby completion settings
let ruby_minlines = 200
let g:rubycomplete_rails = 1
let g:rubycomplete_classes_in_global = 1
let g:ruby_buffer_loading = 1
let g:rubycomplte_include_object = 1
let g:rubycomplete_include_objectspace = 1
if executable($rvm_bin_path . '/' . $rvm_ruby_string)
  let g:ruby_path = $rvm_bin_path . '/' . $rvm_ruby_string
endif

if has("gui_running")
  set t_Co=256
  set guioptions-=T
  colorscheme plasticcodewrap
  set guitablabel=%N\ %M%t

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
else
  " Workaround for making things like arrow keys work under screen
  if $TERM == 'screen*'
    set term=xterm
  elseif $TERM == 'screen-256color'
    set term=xterm-256color
  end

  " Shut CSApprox up so we don't hear any warnings
  let g:CSApprox_verbose_level = 0

  " Color scheme
  set background=dark
  if &t_Co > 255
    colorscheme plasticcodewrap
  else
    colorscheme ir_black
  endif

  " Disable peepopen when not in gui
  let g:peepopen_loaded = 1
endif

" Nerd Commenter settings
let NERDSpaceDelims=1
let NERDCompactSexyComs=1
let NERDCommentWholeLinesInVMode=1

" delimitMate settings
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 0

" Allow for quick jumping over delimiters instead of S-Tab
inoremap ; <C-R>=delimitMate#JumpAny(";")<CR>

" Don't use CR for doing an accept in supertab
let g:SuperTabCrMapping = 0

" Recalculate completion string when hitting tab on an open menu
let g:SuperTabLongestEnhanced = 1
let g:SuperTabRetainCompletionDuration = 'session'
let g:SuperTabMidWordCompletion = 0

" TList settings for ctags
if executable($HOME . "/.homebrew/bin/ctags")
  let Tlist_Ctags_Cmd = $HOME . "/.homebrew/bin/ctags"
elseif !executable("ctags")
  let loaded_taglist = 1
end

" Tlist doesn't seem to work with MacVim and exuberant ctags from homebrew
let Tlist_Compact_Format = 1
let Tlist_Use_Right_Window = 1
let Tlist_Process_File_Always = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Auto_Update = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Open = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Use_SingleClick = 1
let Tlist_Show_Menu = 0
let Tlist_Auto_Open = 1
let Tlist_Display_Prototype = 1
let Tlist_WinWidth = 40
set tags=./tags;

" Make accessing the taglist easier
nnoremap <Leader>l :TlistToggle<CR>

" Make taglist update which section of code we are in faster
set updatetime=1000

" Turn on mouse support
set mouse=a

if has("persistent_undo")
  set undofile
  set undodir=~/.vim/undo,tmp
endif

" Allow inserting just one stupid character
nnoremap <Space> :exec "normal i".nr2char(getchar())."\e"<CR>

" Make using lusty juggler and explorer a bit nicer
" nnoremap <Leader>j :LustyJuggler<CR>
nnoremap <Leader>j :LustyBufferExplorer<CR>
nnoremap <Leader>f :LustyFilesystemExplorerFromHere<CR>
let g:loaded_lustyjuggler = 1

" Nerd Tree settings
let NERDTreeQuitOnOpen = 0
let NERDTreeShowBookmarks = 1
let NERDTreeShowHidden = 1
let NERDTreeWinPos = 'left'
let NERDTreeWinSize = 30
let NERDTreeMouseMode = 3 " Don't require double click to open file
let NERDTreeIgnore=['\~$', '^\.git$', '^\.svn$', '^\.bundle$']
nmap <Leader>d :NERDTreeToggle<CR>

" Find in NerdTree!
nnoremap <silent> <Leader>D :NERDTreeFind<CR>

" Allow a method to delete without updating paste buffer
" Use dlp to do the same as what xp used to do
nnoremap x "_x
nnoremap X "_x
vnoremap x "_x
vnoremap X "_X

" Don't move the cursosr after pasting
" noremap p p`[
" noremap P P`[

" Select just pasted text in last used visual mode
nnoremap <expr> gp '`[' . visualmode() . '`]'

" Use ^L to exit modes and keep cursor where it was
" Commented out for now since ^C does essentially the same
" inoremap <C-l> <ESC>`^
" vnoremap <C-l> <ESC>`^
" snoremap <C-l> <ESC>`^
" onoremap <C-l> <ESC>`^

" Make exiting insert mode not move the cursor to right
" Also makes ^C now trigger abbreviations and InsertLeave autocmd
inoremap <C-c> <ESC>`^

" Make moving around on the line easier in insert move
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Don't put the cursor so close to a windows edge
set scrolloff=10
set sidescrolloff=7
set sidescroll=1

" set up tab labels with tab number, buffer name, number of windows
function! TabLabel()
  let label = ''
  let i = 1
  let current = tabpagenr()

  while i <= tabpagenr('$')
    let bufnrlist = tabpagebuflist(i)

    " Let vim know which tab this delineates
    let label .= '%' . (i == current ? '#TabLineSel#' : '#TabLine#') . ' %' . i . 'T'

    " Append the tab number
    let label .= i . ': '

    " Append the buffer name
    let name = bufname(bufnrlist[tabpagewinnr(i) - 1])
    if name == ''
      " give a name to no-name documents
      if &buftype=='quickfix'
        let name = '[Quickfix List]'
      else
        let name = '[No Name]'
      endif
    else
      " get only the file name
      let name = fnamemodify(name,":p:t")
    endif
    let label .= name . ' '

    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
      if getbufvar(bufnr, "&modified")
        let label .= '[+]'
        break
      endif
    endfor

    " Append the number of windows in the tab page
    let label .= '[' . tabpagewinnr(i, '$') . ']'
    let i += 1
  endwhile

  let label .= '%T%#TabLineFill#%=%999%X'
  return label
endfunction

set tabline=%!TabLabel()

" Make moving between windows easier
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" This makes * and # work on visual mode too.
" http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

" Search for the current word from visual mode
vmap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vmap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" Make shifting in highlight mode reselect text
vnoremap < <gv
vnoremap > >gv

