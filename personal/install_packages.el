; install packages from a list
; to get a list of installed packages C-h v package-activated-list




; list the packages you want
(setq package-list '(ace-jump-buffer ace-jump-mode ace-window ansible ansible-doc anzu avy beacon browse-kill-ring company-anaconda anaconda-mode company-lsp company counsel crux diff-hl diminish discover-my-major dockerfile-mode easy-kill editorconfig elisp-slime-nav esh-buf-stack ess-R-data-view ctable ess-R-object-popup ess-smart-equals ess-smart-underscore exec-path-from-shell expand-region flx-ido flx flycheck geiser gist gh git-commit-mode git-rebase-mode git-timemachine gitconfig-mode gitignore-mode god-mode grizzl grunt guru-mode helm-ag helm-descbinds helm-projectile helm helm-core hl-todo ido-ubiquitous ido-completing-read+ imenu-anywhere json-mode json-reformat json-rpc json-snatcher logito lsp-ui lsp-mode dash-functional magit git-commit magit-popup makey markdown-mode+ markdown-mode marshal ht memoize move-text nginx-mode operate-on-number ov pcache popup projectile pkg-info epl pythonic f r-autoyas ess julia-mode rainbow-delimiters rainbow-mode rjsx-mode js2-mode s scss-mode smart-mode-line rich-minority smartparens smartrep smex spinner stan-snippets stan-mode super-save swiper ivy toggle-quotes transient dash undo-tree visual-regexp volatile-highlights web-mode which-key with-editor async yaml-mode yasnippet zenburn-theme zop-to-char org-journal flycheck-ledger smooth-scroll))

; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
