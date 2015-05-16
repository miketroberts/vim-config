"srt vim: set fmr={{{,}}} fdm=marker et ts=2 sw=2 sts=2 :

if has("win32") || has("win64")
  " They map $HOME to H:\ for some reason. I really don't want that.
  let $HOME = $USERPROFILE
endif

set nocompatible

filetype off
call pathogen#infect()
Helptags

filetype on                                     " Enable filetype detection.
filetype plugin on                              " Enable filetype specific plugins.
filetype indent on                              " Enable filetype specific indentation rules.

" General Settings {{{
    if has("unix")
      set viminfo+=n~/.viminfo
    else
      set viminfo+=n$HOME\\_viminfo            " don't write the _viminfo to the network.
    endif

    set nowrap                                      " don't wrap lines
    set textwidth=0                                 " no line length
    "set number                                      " always show the line numbers

    set hlsearch                                    " highlight search results
    set incsearch                                   " match search results as we type
    set ignorecase                                  " ignore case when searching
    set smartcase                                   " match case if all lower case

    set showmatch                                   " show matching brackets
    set hidden                                      " allow changes to hidden buffers
    "set autochdir                                  " Automatically change to the directory of the file in the active buffer.

    set tabstop=4
    set shiftwidth=4                                " number of spaces for auto indent
    set smarttab
    set expandtab                                   " Get rid of tabs
    set softtabstop=4                               " what distance should a tab *feel* like
    set autoindent                                  " always auto indent
    "set copyindent                                  " copy the indent that came before
    "set smartindent                                 " be smart about our indenting for C based languages
    "set shiftround                                  " Round to multiples

    set smarttab cinwords=if,elif,else,for,while,try,except,finally,def,class

    "set cursorline                                  " highlight the line the cursor is on

    set nobackup                                    " do not create backup files EVER
    set noswapfile                                  " do not create swap files EVER
    if has("unix")
      set backupdir=~/.vim/backup/
      set directory=~/.vim/backup/
    else
      set backupdir=c:\TEMP                           " If you do, do it in a sane place
      set directory=c:\TEMP                           " Same goes for swap
    endif

    set scrolloff=3                                 " Start scrolling when 3 lines from the end of the buffer.
    set sidescroll=5                                " Scroll horizontally 5 chars at a time.
    set sidescrolloff=5                             " Start scrolling when 5 chars from edge of the window.

    set novisualbell                                " Turn off the visual bell.
    set noerrorbells                                " Turn off error notification

    set foldmethod=marker                           " Fold files on markers.

    set wildmenu                                    " Enable the wild menu
    set wildmode=list:longest,full                  " Better completion
    set wildignore =.svn,CVS,.git                   " Ignore VCS files
    set wildignore+=*.o,*.a,*.so                    " Ignore compiled binaries
    set wildignore+=*.jpg,*.png,*.gif               " Ignore images
    set wildignore+=*.pdf                           " Ignore PDF files
    set wildignore+=*.pyc,*.pyo                     " Ignore compiled Python files
    set wildignore+=*.hi,*.ho                       " Ignore compiled Haskell files
    set wildignore+=*.fam                           " Ignore compiled Falcon files
    set wildignore+=.*.class                        " Ignore class files.
    set wildignore+=*build/*                        " Ignore anything under the build directory.

    set mousehide                                   " Hide the mouse when typing

    set matchpairs+=<:>                             " Match angle brackets

    set laststatus=2                                " Always have a status bar.
    set ruler                                       " If status bar is disabled, ensure we atleast have a ruler present
                                                " Make it have the stuff I need.
"    set statusline=%t%m%r%h%w\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

    set backspace=indent,eol,start                  " Backspace can remove anything.

    let mapleader=","                               " Change the map leader to something I can use.

    set pastetoggle=<F2>                            " Toggle between paste mode and normal mode.

    set t_Co=256

    let NERDTreeWinPos="right"                      " Move the nerd tree to the other side of the window.

    syntax on                                       " Enable syntax highlighting.

    " LargeFile.vim settings
    " don't run syntax and other expensive things on files larger than NUM megs
    let g:LargeFile = 10

    " Python settings.
    let python_highlight_all = 1

    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=ucs-bom,utf8,prc
    set ffs=unix,dos

    set listchars=tab:»\ ,extends:>,precedes:<,trail:□
    "set listchars=tab:»\ ,eol:¬,extends:>,precedes:<,trail:□
    "set list                                       " Set this on a per FT basis
    set lazyredraw                                  " Required for airline.

    if has("persistent_undo")
      if has("unix")
        set undodir = "~/.vim/cache/vimundo//"
      else
        set undodir = "d:\\temp\\cache\\vimundo\\"
      endif
      set undofile
    endif
"}}}

" CtrlP Settings {{{
    let g:ctrlp_regexp = 1                          " regexp matching mode
    let g:ctrlp_switch_buffer = 1                   " if file already open in current tab, switch to it.
    let g:ctrlp_working_path_mode = 2               " search up for a marker to define root directory.
    let g:ctrlp_root_markers = ['.root\']           " what is that marker?
    let g:ctrlp_dotfiles = 0                        " don't look at dotfiles.
    let g:ctrlp_use_caching = 1                     " catch the results.
    let g:ctrlp_clear_cache_on_exit = 0             " don't clear the cache

    if has("unix")
      let g:ctrlp_cache_dir = "~/.vim/cache/ctrlp"   " where to cache.
    else
      let g:ctrlp_cache_dir = 'd:\\temp\\cache\\ctrlp'   " where to cache.
    endif

    " custom ignore does not work as we are using a custom user_command
    "let g:ctrlp_custom_ignore = {
    "  \ 'dir': 'build$',
    "  \ 'file': '\.class$\|\.jar$',
    "  \ }

    if has("unix")
      let g:ctrlp_user_command = 'find . -name "\.java$\|\.cpp$|\.h$|\.rb$|\.xml$$" -print | grep -v "*\\build\\*"'
    else
      let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d | grep "\.java$\|\.cpp$|\.h$|\.rb$|\.xml$$" | grep -v "*\\build\\*"'
    endif

    let g:ctrlp_extensions = ['funky']

"    if (v:servername == "JAVA")
"        let g:ctrlp_mruf_include = '\.java$|\.xml$'
"    elseif (v:servername == "RUBY")
"        let g:ctrlp_mruf_include = '\.rb$|\.xml$'
"    elseif (v:servername == "C++")
"        let g:ctrlp_mruf_include = '\.cpp$|\.h$|\.xml$'
"    endif
" }}}

" vim-indent-guides {{{
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_level = 1
" }}}

" Airline {{{
"  let g:airline_theme='zenburn'
  let g:airline_powerline_fonts=0
"  let g:airline_enable_csv=1
  let g:airline#extensions#whitespace#enabled=0
  let g:airline_left_sep=''
  let g:airline_right_sep=''
" }}}

" Solarized {{{
  let g:solarized_visibility="high"
" }}}

" Molokai {{{
let g:molokai_original=1
" }}}

" Powerline {{{
let g:Powerline_cache_dir = "d:\\temp\\"
" }}}

" UltiSnips {{{
" }}}

"  Eclim {{{
let g:EclimLogLevel = "trace"
let g:EclimDisabled = 0
"  }}}

" Vim-Filer {{
"let g:vimfiler_as_default_explorer = 1
" }}}

" Custom Colors {{{
function! SetCursorColor()
  highlight Cursor guifg=black guibg=steelblue
  highlight iCursor guifg=black guibg=steelblue
  highlight vCursor guifg=black guibg=steelblue
endfunction

autocmd ColorScheme * call SetCursorColor()
call SetCursorColor()

"hi ColorColumn=#d0d0d0
" }}}

if has("unix")
  let g:notes_directories=["~/.vim/notes//"]
else
  let g:notes_directories=['C:\\Users\\mroberts\\Documents\\notes\\']
endif

if (has('gui_running'))
    set guioptions=egt
    "set guifont=Source_Code_Pro_Semibold:h9:cANSI
    "set guifont=Consolas:h9:cANSI
    "set guifont=Mensch_for_Powerline:h9:cANSI
    set guifont=Droid_Sans_Mono:h8:cANSI
    "set guifont=Monaco:h9:cANSI
    "set guifont=DejaVu_Sans_Mono:h8:cANSI
    "set guifont=Fantasque_Sans_Mono:h10:cANSI
    "set guifont=@M+_2m_regular:h10:cANSI
    set guifontwide=NSimsun:h10
    set background=dark

    set guicursor=n-c:block-Cursor-blinkon0
    set guicursor+=v:block-vCursor-blinkon0
    set guicursor+=i-ci:hor25-vCursor-blinkon0
endif

"colorscheme zenburn 
"colorscheme corporation
"colorscheme base16-ateliersavanna
colorscheme base16-flat

" Mappings {{{
  "  Mapping to allow quick directory change to directory of current file.
  map <leader>cd :cd %:p:h<CR>

  " Quickly edit/reload the vimrc file
  nmap <silent> <leader>ev :e $MYVIMRC<CR>
  nmap <silent> <leader>sv :so $MYVIMRC<CR>

  " Quickly clear the current search hilights
  nmap <silent> <leader>/ :let @/=""<CR>

  " Shortcut to rapidly toggle `set list`
  nmap <leader>l :set list!<CR>

  map <F3> :Bufferlist<CR>

  map <leader>b :CtrlPBuffer<CR>

  " highlight group
  nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

  " Clean trailing whitespace
  nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

  " Invoke CtrlP with the word under the cursor.
  nmap <leader>lw :CtrlP<CR><C-\>w
"}}}

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"here is a more exotic version of my original Kwbd script
"delete the buffer; keep windows; create a scratch buffer if no buffers left
function! s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction

function! s:DefaultWinPosition()
  winpos 2558, 0
  set columns=319
  set lines=78
endfunction

command! DefaultWinPosition call s:DefaultWinPosition()<CR>

command! Kwbd call s:Kwbd(1)
nnoremap <silent> <Plug>Kwbd :<C-u>Kwbd<CR>

" Create a mapping (e.g. in your .vimrc) like this:
nmap <C-W>! <Plug>Kwbd


function! CallVisualStudio() 
  silent !"d:\\bin\\OpenFileToLine.exe %:p " . line(".") . " " . col(".")
endfunction

function! CallRemoteVim()
  silent !"c:\\
endfunction

map <leader>j call CallVisualStudio<CR>
