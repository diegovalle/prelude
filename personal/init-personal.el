;; Personal emacs setting for Diego Valle
;; to reload this file M-x eval-buffer

;; install additional packages - add anyto this list that you want to
;; be installed automatically
;; (prelude-require-packages '(multiple-cursors ess))

(setq ledger-post-auto-adjust-amounts t)

;;smooth scrolling
(setq prelude-use-smooth-scrolling t)


;; shortcut to commonly used files
;; C-x r j e
(set-register ?e (cons 'file "~/.emacs.d/personal/init-personal.el"))
;; C-x r j l
(set-register ?l (cons 'file "~/Documents/org/ledger/journal.ledger"))
;; C-x r j t
(set-register ?t (cons 'file "~/Documents/org/todo.org"))


(setq default-frame-alist '((font . "Consolas-13")))

(define-key global-map (kbd "C-c l") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
;; if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)


;; (package-initialize)
(load-theme 'monokai-pro t)

;; (require 'linum-highlight-current-line-number)

(require 'hl-line)

;; (defface my-linum-hl
;;   `((t :inherit linum :background ,(face-background 'hl-line nil t)))
;;   "Face for the current line number."
;;   :group 'linum)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
;; (add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)


;;(setq linum-format "%d \u2502 ")

(customize-set-variable 'org-journal-dir "~/Documents/org/journal/")
(customize-set-variable 'org-journal-date-format "%A, %B %d, %Y")
(require 'org-journal)

;; from http://stackoverflow.com/questions/3633120/emacs-hotkey-to-align-equal-signs
;; another information: https://gist.github.com/700416
;; use rx function http://www.emacswiki.org/emacs/rx


(defun align-to-colon (begin end)
  "Align region to colon (:) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ":") 1 1 ))

(defun align-to-comma (begin end)
  "Align region to comma  signs"
  (interactive "r")
  (align-regexp begin end
                (rx "," (group (zero-or-more (syntax whitespace))) ) 1 1 ))


(defun align-to-equals (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "=") 1 1 ))

(defun align-to-hash (begin end)
  "Align region to hash ( => ) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) "=>") 1 1 ))

;; work with this
(defun align-to-comma-before (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ",") 1 1 ))

;;(require 'smooth-scroll)
;;(smooth-scroll-mode t)

;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with <open> and enter text in its buffer.


(use-package emacs
             :config
             (setq-default scroll-preserve-screen-position t)
             (setq-default scroll-conservatively 1) ; affects `scroll-step'
             (setq-default scroll-margin 0)

             (define-minor-mode prot/scroll-centre-cursor-mode
               "Toggle centred cursor scrolling behaviour."
               :init-value nil
               :lighter " S="
               :global nil
               (if prot/scroll-centre-cursor-mode
                   (setq-local scroll-margin (* (frame-height) 2)
                               scroll-conservatively 0
                               maximum-scroll-margin 0.5)
                 (dolist (local '(scroll-preserve-screen-position
                                  scroll-conservatively
                                  maximum-scroll-margin
                                  scroll-margin))
                   (kill-local-variable `,local))))

             ;; C-c l is used for `org-store-link'.  The mnemonic for this is to
             ;; focus the Line and also works as a variant of C-l.
             :bind ("C-c L" . prot/scroll-centre-cursor-mode))

(use-package mouse
             :config
             ;; In Emacs 27, use Control + mouse wheel to scale text.
             (setq mouse-wheel-scroll-amount
                   '(1
                     ((shift) . 5)
                     ((meta) . 0.5)
                     ((control) . text-scale)))
             (setq mouse-drag-copy-region nil)
             (setq make-pointer-invisible t)
             (setq mouse-wheel-progressive-speed t)
             (setq mouse-wheel-follow-mouse t)
             :hook (after-init-hook . mouse-wheel-mode))

(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-set-bar 'under)
;;  (centaur-tabs-change-fonts "arial" 160)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

(require 'sublimity)
(require 'sublimity-scroll)
;;(require 'sublimity-map) ;; experimental
;;(require 'sublimity-attractive)
(sublimity-mode 1)

(require 'flycheck-vale)
(flycheck-vale-setup)

;; ledger stuff
(setq ledger-post-amount-alignment-at :decimal)
(setq undo-limit 800000
      undo-strong-limit 12000000
      undo-outer-limit 120000000)

(defun generate-buffer()
      "Make a temporary buffer and switch to it - Like C-n for Sublime etc"
  (interactive)
  (switch-to-buffer (get-buffer-create (concat "tmp-" (format-time-string "%m.%dT%H.%M.%S")))))


; persistent storage

(setq persistent-scratch-save-file "~/Documents/scratch/persistent-scratch")
(setq persistent-scratch-backup-directory "~/Documents/scratch")
(persistent-scratch-setup-default)
(persistent-scratch-autosave-mode 1)
(ignore-errors (persistent-scratch-restore))

(defun rmd-mode ()
  "ESS Markdown mode for rmd files"
  (interactive)
  ;;(setq load-path
    ;;    (append (list "path/to/polymode/" "path/to/polymode/modes/")
      ;;          load-path))
  (require 'poly-R)
  (require 'poly-markdown)
  (poly-markdown+r-mode))

;; associate the new polymode to Rmd files:
(add-to-list 'auto-mode-alist
'("\\.[rR]md\\'" . poly-gfm+r-mode))
;; uses braces around code block language strings:
(setq markdown-code-block-braces t)
