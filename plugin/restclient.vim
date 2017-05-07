if exists('g:loaded_restclient')
  finish
endif
let g:loaded_restclient = 1

function! s:shcmd(code)
  return 'emacs --quick --batch --eval="'.a:code.'"'
endfunction

function! s:stdout(c)
  let null = &shell !~? 'sh[^\/]*$' ? ' 2> nul' : ' 2>/dev/null'
  if has('nvim')
    return system(a:c.null)
  else
    let shell = &shellredir
    let &shellredir = substitute(shell,'\C^>%s\zs 2>&1$',null,'')
    let [ret, &shellredir] = [system(a:c), shell]
    return ret
  endif
endfunction

function! s:elisp(name,format)
  return '(progn (setq restclient-log-request nil package-load-list ''((restclient t)))'
        \ .'(with-temp-buffer (insert \"'.escape(escape(escape(join(getline(1,'$'),'\n'),'\"'),'"'),'"').'\")'
        \ . '(package-initialize)(require ''restclient)(restclient-mode)'
        \ . '(goto-char (point-min))'
        \ . '(forward-line (1- '.line('.').'))('.a:name.')'
        \ . '(while restclient-within-call (sit-for 0.05))'.a:format.'(terpri))(kill-emacs 0))'
endfunction

function! s:do(...)
  return s:stdout(s:shcmd(call('s:elisp',a:000)))
endfunction

function! s:cURL()
  return substitute(s:do('restclient-copy-curl-command',
        \ '(princ (current-kill 0))' ),'\_s*\%$','','')
endfunction

command! -register RestclientCurl call setreg(<q-reg>, s:cURL())

command! -nargs=? Restclient echon s:do('restclient-http-send-current'.matchstr(<q-args>,'\C^-raw\ze\s*$'),
      \ '(set-buffer \"*HTTP Response*\" )(princ (buffer-substring-no-properties (point-min)(point-max)))' )
