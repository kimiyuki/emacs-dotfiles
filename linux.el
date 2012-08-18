(add-to-list 'load-path "/usr/share/emacs/site-lisp/")

;;rcode-tools
(add-to-list 'load-path "/var/lib/gems/1.9.1/gems/rcodetools-0.8.5.0")
(require 'rcodetools)
(setq rct-find-tag-if-available nil)
(defun make-ruby-scratch-buffer ()
  (with-current-buffer (get-buffer-create "*ruby scratch*")
    (ruby-mode)
    (current-buffer)))
(defun ruby-scratch ()
  (interactive)
  (pop-to-buffer (make-ruby-scratch-buffer)))
(defun xmp-comment-toggle ()
  (interactive)
  (save-excursion
    (if (re-search-forward "# *=>.*" (+ (line-end-position) 1) t 1)
	(replace-match "")
      (end-of-line)(insert " # =>"))))
(defun ruby-mode-hook-rcodetools ()
  (define-key ruby-mode-map "\M-i" 'rct-complete-symbol)
  (define-key ruby-mode-map "\C-c\C-t" 'ruby-toggle-buffer)
  (define-key ruby-mode-map "\C-c\C-d" 'xmp)
  (define-key ruby-mode-map "\C-c\C-f" 'rct-ri)
  (define-key ruby-mode-map "\C-c\C-c" 'xmp-comment-toggle)
  )
(add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)

(require 'anything-rcodetools)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(completion-ignored-extensions (quote (".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".fasl" ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl" ".p64fsl" ".d64fsl" ".dx64fsl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo")))
 '(cua-mode t nil (cua-base))
 '(display-time-mode t)
 '(org-babel-load-languages (quote ((R . t) (emacs-lisp))))
 '(org-confirm-babel-evaluate nil)
 '(safe-local-variable-values (quote ((outline-minor-mode))))
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal :foundry "bitstream" :family "Courier 10 Pitch")))))


;;;; ever-note
(add-to-list 'load-path "~/Dropbox/.emacs.d/emacs-evernote-mode-read-only/")
(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; option
(setq evernote-ruby-command "/usr/bin/ruby")
(require 'evernote-mode)
(setq evernote-username "kimiyuki") ; optional: you can use this username as default.
(global-set-key "\C-cec" 'evernote-create-note)
(global-set-key "\C-ceo" 'evernote-open-note)
(global-set-key "\C-ces" 'evernote-search-notes)
(global-set-key "\C-ceS" 'evernote-do-saved-search)
(global-set-key "\C-cew" 'evernote-write-note)
(global-set-key "\C-cep" 'evernote-post-region)
(global-set-key "\C-ceb" 'evernote-browser)

;;(global-auto-complete-mode t) ;;;;migemoが使えなくなる=> migemo-toggle-isearch-enableする
;;(require 'migemo)
;;(setq migemo-command "/usr/bin/ruby1.8")
;;(load "migemo")

(require 'php-mode)

;;MEW
; IMAP for Gmail
(setq mew-proto "%")
(setq mew-user "kimiyuki")
(setq mew-mail-domain "gmail.com")

(setq mew-imap-server "imap.gmail.com")
(setq mew-imap-user "kimiyuki@gmail.com")
(setq mew-imap-auth  t)
(setq mew-imap-ssl t)
(setq mew-imap-ssl-port "993")
(setq mew-smtp-auth t)
(setq mew-smtp-ssl t)
(setq mew-smtp-ssl-port "465")
(setq mew-smtp-user "kimiyuki@gmail.com")
(setq mew-smtp-server "smtp.gmail.com")



(require 'magit)
(global-set-key (kbd "C-x v d") 'magit-status)
(global-set-key (kbd "C-x v L") 'magit-key-mode-popup-logging)
(global-set-key (kbd "C-x v z") 'magit-stash)
(define-key magit-mode-map "\C-\M-l" "l-all" )

;;for remote edit by root
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/sshx:%h:"))))

(require 'migemo)
(setq migemo-command "/usr/bin/cmigemo")
(setq migemo-options '("-q" "--emacs"))
;; If you want to use UTF-8
(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
(setq migemo-coding-system 'utf-8-unix)


;;(add-to-list 'load-path "~/eev-current")
;;(require 'eev-all)
;;(global-set-key (kbd "M-e") 'eek-eval-sexp-eol)
;;(global-set-key (kbd "M-k") 'kill-this-buffer)

