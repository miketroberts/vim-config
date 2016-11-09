autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 999999 line=1 name=dummy buffer=' . bufnr('')
