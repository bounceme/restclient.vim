function! s:shcmd(code)
  return join(['emacs',s:writetemp(),'--quick','--batch','--eval="']).a:code.'" 2>/dev/null'
endfunction

function! s:elisp(name,format)
  return '(progn (setq package-load-list ''((restclient t)))(package-initialize)(require ''restclient)(restclient-mode)'
        \ .'(goto-char (point-min))'
        \ .'(forward-line (1- '.line('.').'))('.a:name.')'
        \ .'(while restclient-within-call (sit-for 0.05))'.a:format.'(terpri)(kill-emacs 0))'
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

command! Restclient echon system(s:shcmd(s:elisp('restclient-http-send-current',
      \ '(switch-to-buffer \"*HTTP Response*\" )(princ (buffer-substring-no-properties (point-min)(point-max)))' )))
