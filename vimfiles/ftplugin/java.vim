" Vim filetype plugin file
" Language:	Java
" Maintainer:	Dan Sharp <dwsharp at users dot sourceforge dot net>
" Last Change:  20 Jan 2009
" URL:		http://dwsharp.users.sourceforge.net/vim/ftplugin

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo
set cpo-=C

" For filename completion, prefer the .java extension over the .class
" extension.
set suffixes+=.class

" Enable gf on import statements.  Convert . in the package
" name to / and append .java to the name, then search the path.
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal suffixesadd=.java
if exists("g:ftplugin_java_source_path")
    let &l:path=g:ftplugin_java_source_path . ',' . &l:path
endif

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal formatoptions-=t formatoptions+=croql

" Set 'comments' to format dashed lists in comments. Behaves just like C.
setlocal comments& comments^=sO:*\ -,mO:*\ \ ,exO:*/

setlocal commentstring=//%s

" Change the :browse e filter to primarily show Java-related files.
if has("gui_win32")
    let  b:browsefilter="Java Files (*.java)\t*.java\n" .
		\	"Properties Files (*.prop*)\t*.prop*\n" .
		\	"Manifest Files (*.mf)\t*.mf\n" .
		\	"All Files (*.*)\t*.*\n"
endif

" Undo the stuff we changed.
let b:undo_ftplugin = "setlocal suffixes< suffixesadd<" .
		\     " formatoptions< comments< commentstring< path< includeexpr<" .
		\     " | unlet! b:browsefilter"

" Restore the saved compatibility options.
let &cpo = s:save_cpo

let lnum = prevnonblank(v:lnum - 1)
let line = getline(lnum)
if line =~ '^\s*@.*$'
    let theIndent = indent(lnum)
endif

set tabstop=4
set shiftwidth=4
set softtabstop=4
"set colorcolumn=join(range(120,999),",")
set list
let java_space_errors=1
let java_no_trail_space_error=1
let java_no_tab_space_error=1

" Eclim uses the sign column, however if there are no symbols, it will
" appear/disapear. Force it to always appear by defining a dummy symbol
" and forcing it into every buffer.
"autocmd BufEnter * sign define dummy
"autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
