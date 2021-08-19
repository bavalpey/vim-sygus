setlocal commentstring=;%s
setlocal iskeyword+=-,:,#,',$

nnoremap <silent> <buffer> <localleader>r :call sygus#solver#Run()<cr>
nnoremap <silent> <buffer> <localleader>R :call sygus#solver#RunAndShowResult()<cr>
nnoremap <silent> <buffer> <localleader>v :call sygus#solver#PrintVersion()<cr>
