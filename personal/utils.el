
;;cool lambda character
;;(require 'lambda-mode)
;;(add-hook 'python-mode-hook #'lambda-mode 1)
;;(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))

;;(elscreen-start)
(global-set-key "\C-x\C-b" 'ibuffer)

;; resize window on start
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 175))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 200)
                             (frame-char-height)))))))

(set-frame-size-according-to-resolution)

;; emacs droppings in their own directory
(setq backup-directory-alist `(("." . "~/.saves")))
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;;autocomplete only works on R files if I add this????
(setq ess-use-auto-complete 'script-only)

;; Auto complete
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)


;; line numbers
(global-linum-mode 1)
(setq linum-format "%3d");" \u2502 ")


;; nice fonts
(defun font-existsp (font)
  "Check to see if the named FONT is available."
  (if (null (x-list-fonts font))
      nil t))

(cond
 ((eq window-system nil) nil)
 ((font-existsp "PragmataPro")
  (set-face-attribute 'default nil :height 121 :font "PragmataPro"))
 ((font-existsp "Menlo")
  (set-face-attribute 'default nil :height 121 :font "Meslo"))
 ((font-existsp "Consolas")
  (set-face-attribute 'default nil :height 121 :font "Consolas"))
 ((font-existsp "Inconsolata")
  (set-face-attribute 'default nil :height 121 :font "Inconsolata"))
 )

;; whitespace-mode
;; free of trailing whitespace and to use 80-column width, standard indentation
;;(setq whitespace-style '(trailing lines space-before-tab
;;                                  indentation space-after-tab)
;;      whitespace-line-column 80)
