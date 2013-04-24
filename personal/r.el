;;; R.el --- Configure R just the way I like it
;;
;; Copyright (c) 2013 Diego Valle Jones
;;

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file simply sets up R
;; Use shift-enter to split window & launch R (if not running), execute highlighted
;; region (if R running & area highlighted), or execute current line
;; (and move to next line, skipping comments). Nice.
;; See http://www.emacswiki.org/emacs/EmacsSpeaksStatistics,
;; FelipeCsaszar. Adapted to spilit vertically instead of
;; horizontally.

;;; Code:

;; Use shift-enter to split window & launch R (if not running), execute highlighted
;; region (if R running & area highlighted), or execute current line
;; (and move to next line, skipping comments). Nice.
;; See http://www.emacswiki.org/emacs/EmacsSpeaksStatistics,
;; FelipeCsaszar. Adapted to spilit vertically instead of
;; horizontally.
;; Adapted with one minor change from Felipe Salazar at
;; http://www.emacswiki.org/emacs/EmacsSpeaksStatistics

(setq ess-ask-for-ess-directory nil)
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)
(defun my-ess-start-R ()
  (interactive)
  (if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
      (progn
        (delete-other-windows)
        (setq w1 (selected-window))
        (setq w1name (buffer-name))
        (setq w2 (split-window w1 nil t))
        (R)
        (set-window-buffer w2 "*R*")
        (set-window-buffer w1 w1name))))
(defun my-ess-eval ()
  (interactive)
  (my-ess-start-R)
  (if (and transient-mark-mode mark-active)
      (call-interactively 'ess-eval-region)
    (call-interactively 'ess-eval-line-and-step)))
(add-hook 'ess-mode-hook
          '(lambda()
             (local-set-key [(ctrl return)] 'my-ess-eval)))
(add-hook 'inferior-ess-mode-hook
          '(lambda()
             (local-set-key [C-up] 'comint-previous-input)
             (local-set-key [C-down] 'comint-next-input)))
(add-hook 'Rnw-mode-hook
          '(lambda()
             (local-set-key [(shift return)] 'my-ess-eval)))
(require 'ess-site)



;;describe data.frames in R
(require 'ess-R-object-popup)
(define-key ess-mode-map "\C-c\C-g" 'ess-R-object-popup)

;;don't prompt on exit
(setq inferior-ess-exit-command "q('no')")
'(inferior-R-args "--no-save --no-restore-data --quiet")

;;; R.el ends here
