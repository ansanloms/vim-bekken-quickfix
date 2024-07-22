if exists("b:current_syntax")
  finish
endif

runtime! syntax/qf.vim
unlet b:current_syntax

let b:current_syntax = "bekken-result-quickfix-grep"
