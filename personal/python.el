(package-initialize)
(elpy-enable)

(require 'ipython)

(add-hook 'python-mode-hook 'jedi:setup)
 
(require 'python-django)

(require 'ido)
  (ido-mode t)
