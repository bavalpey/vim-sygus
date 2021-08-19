" Code adapted mostly verbatim from https://github.com/bohlender/vim-smt2/blob/2cc8c80c0a88e0d47de85bef1d50df86e197c302/autoload/smt2/solver.vim
" Original code published under MIT license (copyright line below)
" Copyright (c) 2017 Dimitri Bohlender

" ------------------------------------------------------------------------------
" Config
" ------------------------------------------------------------------------------
" If no command for invoking a solver is specified in ~/.vimrc, test if either
" 'z3' or 'boolector' is accessible through $PATH (in that order)
if !exists("g:sygus_solver_command")
    if executable("cvc5")
        let g:sygus_solver_command = "cvc5"
    elseif executable("cvc4")
        let g:sygus_solver_command = "cvc4"
    endif
endif

" If no command line switch for printing the solver's version is specified in
" ~/.vimrc, use '--version'
if !exists("g:sygus_solver_version_switch")
    let g:sygus_solver_version_switch = "--version"
endif

" ------------------------------------------------------------------------------
" Public functions
" ------------------------------------------------------------------------------
" Invokes the solver on current file
function! sygus#solver#Run()
    silent !clear
    execute "!" . g:sygus_solver_command . " " . bufname("%")
endfunction

" Puts the solver's output in new split (replaces old split)
function! sygus#solver#RunAndShowResult()
    let output = system(g:sygus_solver_command . " " . bufname("%") . " 2>&1")

    " Create split (or reuse existent)
    if exists("s:outputbufnr") && bufwinnr(s:outputbufnr) > 0
        execute bufwinnr(s:outputbufnr) . 'wincmd w'
    else
        silent! vnew
        let s:outputbufnr=bufnr('%')
    endif

    " Clear & (re-)fill contents
    silent! normal! ggdG
    setlocal filetype=smt2 buftype=nofile nobuflisted noswapfile
    call append(0, split(output, '\v\n'))
    normal! gg
endfunction

" Requests the solver's version
function! sygus#solver#PrintVersion()
    silent !clear
    execute "!" . g:sygus_solver_command . " " . g:sygus_solver_version_switch
endfunction
