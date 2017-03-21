if exists('g:loaded_restclient')
  finish
endif
let g:loaded_restclient = 1

function! s:shcmd(code)
  return join(['emacs',s:writetemp(),'--quick','--batch','--eval="']).a:code.'"'
endfunction

function! s:elisp(name,format)
  return '(progn (setq restclient-log-request nil package-load-list ''((restclient t)))'
        \ .'(package-initialize)(require ''restclient)(restclient-mode)'
        \ .'(goto-char (point-min))'
        \ .'(forward-line (1- '.line('.').'))('.a:name.')'
        \ .'(while restclient-within-call (sit-for 0.05))(terpri)'.a:format.'(terpri)(kill-emacs 0))'
endfunction

let s:f = tempname()

augroup restclient
  au!
augroup END

au restclient vimLeavePre * call delete(s:f)

function! s:writetemp()
  call writefile(getline(1,'$'),s:f)
  return s:f
endfunction

command! -register RestclientCurl call setreg(<q-reg> isnot '' ? <q-reg> : v:register,
      \ substitute(system(s:shcmd(s:elisp('restclient-copy-curl-command',
      \ '(princ (current-kill 0))' ))),
      \ '\%^\_s*\_.\{-}\n\n','','')[:-2])

command! Restclient echon substitute(system(s:shcmd(s:elisp('restclient-http-send-current',
      \ '(set-buffer \"*HTTP Response*\" )(princ (buffer-substring-no-properties (point-min)(point-max)))' ))),
      \ '\%^\_s*\_.\{-}\n\n','','')
