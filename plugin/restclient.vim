function! s:shcmd(code)
  return join(['emacs',expand('%'),'--quick','--batch','--eval="']).join(a:code,line('.')).'" 2>/dev/null'
endfunction

function! s:elisp(name,format)
  return ['(progn (setq package-load-list ''((restclient t)))(package-initialize)(require ''restclient)(restclient-mode)'
        \ .'(goto-char (point-min))'
        \ .'(forward-line (1- ','))('.a:name.')'
        \ .'(while restclient-within-call (sit-for 0.05))'.a:format.'(terpri)(kill-emacs 0)))']
endfunction

command! Restclient echon system(s:shcmd(s:elisp('restclient-http-send-current',
      \ '(switch-to-buffer \"*HTTP Response*\" )(princ (buffer-substring-no-properties (point-min)(point-max)))' )))
