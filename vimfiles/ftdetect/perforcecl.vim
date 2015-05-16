au BufRead,BufNewFile * call s:Check_p4()

func! s:Check_p4()
    if getline(1) =~ '^# A Perforce Change Specification.'
        setf perforcecl
    endif
endfunc

