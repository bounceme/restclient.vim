## An interactive HTTP client for Emacs in vim. *alpha quality*

#### [restclient.el](https://github.com/pashky/restclient.el) which you can use in Vim!

there is overhead, less than you might think though, around 300ms. Rather than `C-cC-c` you just run `:Restclient`.

For installing in the comfort of your shell, just run:
<pre>emacs --quick --batch --eval="(progn(require 'package) (package-initialize) (add-to-list 'package-archives '(\"melpa\" . \"http://melpa.milkbox.net/packages/\") t) (setq url-http-attempt-keepalives nil) (package-refresh-contents) (package-install 'restclient))"<pre>

The http response gets displayed in vim's internal pager, but this can be changed however, see `:h :redir`
