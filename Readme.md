## An interactive HTTP client for Emacs in vim. *alpha quality*

#### [restclient.el](https://github.com/pashky/restclient.el) which you can use in Vim!

there is overhead, less than you might think though, around 300ms. Rather than `C-cC-c` you just run `:Restclient`.

To get the equivalent as a Curl command, use `:RestclientCurl` , which will put it in the unnamed register, or any register, by using `"<reg of your choosing>:RestclientCurl<cr>` in normal mode.

For installing in the comfort of your shell, just run:
<pre>emacs --quick --batch --eval="(progn(require 'package) (package-initialize) (add-to-list 'package-archives '(\"melpa\" . \"http://melpa.milkbox.net/packages/\") t) (setq url-http-attempt-keepalives nil) (package-refresh-contents) (package-install 'restclient))"</pre>

For basic syntax highlighting, when editing requests, `:set ft=conf`. The response gets displayed in vim's internal pager, but this can be changed however, see `:h :redir`
