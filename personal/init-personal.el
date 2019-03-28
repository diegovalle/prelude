;; Personal emacs setting for Diego Valle
;; to reload this file M-x eval-buffer

;;Add MELPA repository for packages
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

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

(global-linum-mode t)

(setq default-frame-alist '((font . "Consolas-13")))

(define-key global-map (kbd "C-c l") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
;; if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)


(package-initialize)
(load-theme 'darkplus)

(require 'linum-highlight-current-line-number)

(require 'hl-line)

(defface my-linum-hl
  `((t :inherit linum :background ,(face-background 'hl-line nil t)))
  "Face for the current line number."
  :group 'linum)

(add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)

(defun my-linum-get-format-string ()
  (let* ((width (1+ (length (number-to-string
                             (count-lines (point-min) (point-max))))))
         (format (concat "%" (number-to-string width) "d \u2502")))
    (setq my-linum-format-string format)))

(defvar my-linum-current-line-number 0)

(setq linum-format 'my-linum-format)

(defun my-linum-format (line-number)
  (propertize (format my-linum-format-string line-number) 'face
              (if (eq line-number my-linum-current-line-number)
                  'my-linum-hl
                'linum)))

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)

(setq linum-format 'linum-highlight-current-line-number)
;;(setq linum-format "%d \u2502 ")

(customize-set-variable 'org-journal-dir "~/Documents/org/journal/")
(customize-set-variable 'org-journal-date-format "%A, %B %d, %Y")
(require 'org-journal)
