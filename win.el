(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(display-time-mode t)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family #("ÉÅÉCÉäÉI" 0 4 (charset cp932-2-byte)) :foundry "outline" :slant normal :weight normal :height 143 :width normal)))))

(load-library "migemo")
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs" "-i" "\a"))
(setq migemo-dictionary (expand-file-name "c:\cmigemo/dict/utf-8/migemo-dict"))
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1000)
(setq migemo-coding-system 'utf-8-unix)
(migemo-init)

;;(require 'magit)
;;(global-set-key (kbd "C-x v d") 'magit-status)
;;(global-set-key (kbd "C-x v L") 'magit-key-mode-popup-logging)
;;(global-set-key (kbd "C-x v z") 'magit-stash)
;;(define-key magit-mode-map "\C-\M-l" "l-all" )
