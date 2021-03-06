## An interactive HTTP client for Emacs in vim.

#### [restclient.el](https://github.com/pashky/restclient.el) which you can use in Vim!

there is overhead, less than you might think though, around 300ms. Rather than `C-cC-c` you just run `:Restclient`. For unformatted response output append ` -raw`, like so: `:Restclient -raw`

To get the equivalent as a cURL command, use `:RestclientCurl` , which takes an optional register, and copies.

For installing in the comfort of your shell, just run:
<pre>emacs --quick --batch --eval="(progn(require 'package) (package-initialize) (add-to-list 'package-archives '(\"melpa\" . \"http://melpa.milkbox.net/packages/\") t) (setq url-http-attempt-keepalives nil) (package-refresh-contents) (package-install 'restclient))"</pre>

For basic syntax highlighting, when editing requests, `:set ft=conf`. The response gets displayed in vim's internal pager, but this can be changed however, see `:h :redir`
