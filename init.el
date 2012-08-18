(setq user-emacs-directory "~/Dropbox/.emacs.d/")
(add-to-list 'load-path "~/Dropbox/.emacs.d/")
(add-to-list 'load-path "~/Dropbox/.emacs.d/auto-install")

(setq desktop-save-f)
(savehist-mode 1)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))

;;;machine別設定
(cond
 ((eq window-system 'x)
  (load "~/Dropbox/.emacs.d/linux.el")
  (setq savehist-file "~/Dropbox/.emacs.d/tmp/savehist-vm"))
 ((string-equal (system-name) "MAIN7")
  (load "~/Dropbox/.emacs.d/win.el")
  (setq savehist-file "~/Dropbox/.emacs.d/tmp/savehist-w7"))
 ((string-equal (system-name) "shirai-xp")
    (load "~/Dropbox/.emacs.d/win.el")
    (setq savehist-file "~/Dropbox/.emacs.d/tmp/savehist-xp"))
 )

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; この2行を加える
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq url-http-attempt-keepalives nil) ; To fix MELPA problem.
(setq package-user-dir "~/Dropbox/.emacs.d/elpa")
(package-initialize)


(global-linum-mode t)

;; essは make all; make install
(require 'ess-site)
(setq ess-ask-for-ess-directory nil)
(define-key ess-mode-map [(shift return)] 'ess-eval-line-and-step)
(define-key ess-mode-map "\C-c \C-p" 'ess-eval-function-or-paragraph-and-step)
(define-key ess-mode-map "\C-c \C-r" 'ess-eval-region)

;;;;ess-rdired
(autoload 'ess-rdired "ess-rdired" "View *R* objects in a dired-like buffer." t)

(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-x ?") 'help-command)
;; C-x bでミニバッファにバッファ候補表示
;; C-zでsuspend frame　要らない
(global-unset-key "\C-z")
;; M-kでカレントバッファを閉じる
(define-key global-map (kbd "M-k") 'kill-this-buffer)

;; C-returnで矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\C-m" 'newline)
(global-set-key "\C-j" 'newline-and-indent)
(global-set-key "\C-x\C-i" 'indent-region)
(global-set-key (kbd "C-x r i") 'string-insert-rectangle)
;; I needs to understand lisp
(global-set-key (kbd "C-]") 'other-window)
(global-set-key (kbd "C-,") 'beginning-of-buffer)
(global-set-key (kbd "C-.") 'end-of-buffer)
;;;(global-set-key [?\M-k]'(lambda() (interactive)(move-beginning-of-line nil)(kill-line)))
(global-set-key [?\C-\;] 'undo)
;; カーソル動かさずにスクロール
(defun scroll-up-in-place (n) (interactive "p")  (scroll-down n))
(defun scroll-down-in-place (n) (interactive "p")  (scroll-up n))
(global-set-key "\M-p" 'scroll-up-in-place)
(global-set-key "\M-n" 'scroll-down-in-place)
(add-hook 'find-file-hooks
          '(lambda ()
             (setq mode-line-buffer-identification 'buffer-file-truename)))
(defalias 'exit 'save-buffers-kill-emacs)
(setq-default indent-tabs-mode nil) ;tabではなくspaceを使う

(global-set-key [f12] 'uncomment-region)
(global-set-key [f11] 'comment-region)

;; for auto-install
(require 'auto-install)
(setq auto-install-directory "~/Dropbox/.emacs.d/auto-install/")
(add-to-list 'load-path "~/Dropbox/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; anything
(require 'anything-startup)
(require 'anything-config)
(setq anything-sources '(anything-c-source-buffers
                         anything-c-source-bookmarks
                         anything-c-source-recentf
                         anything-c-source-file-name-history
                         anything-c-source-locate))
(global-set-key (kbd "C-;") 'anything)
(global-set-key (kbd "M-x") '(lambda ()
                               "search only in commands"
                               (interactive)
                               (anything '(anything-c-source-extended-command-history
                                           anything-c-source-emacs-commands))) )
(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(global-set-key (kbd "M-l") 'anything-for-files)

(require 'descbinds-anything)
(descbinds-anything-install)


(require 'anything-match-plugin)
(require 'anything-migemo)


;;;moccur anything-moccr
(require 'color-moccur)
(add-to-list 'load-path "~/Dropbox/.emacs.d/anything-c-moccur/")
(require 'anything-c-moccur)
(setq anything-c-moccur-anything-idle-delay 0.2
       ;;anything-idle-delay'
       anything-c-moccur-higligt-info-line-flag t
       ; ;anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
       anything-c-moccur-enable-auto-look-flag t
       anything-c-moccur-enable-initial-pattern t)
       ; ;anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)
(require 'popwin)
(setq anything-samewindow nil)
(push '("*anything*" :height 40) popwin:special-display-config)


;;;screenを上下逆さまに
(defun swap-screen-with-screen()
  "Swap two screen, leaving cursor at current window"
  (interactive)
  (let ((thiswin (selected-window))
	(thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
(global-set-key [f2] 'swap-screen-with-screen)


;; org-mode
(require 'org)
(require 'ob)
(setq org-export-default-language "ja")
(setq org-export-html-coding-system 'utf-8)
;;行頭の:は使わない。BEGIN_EXAMPLE, END_EXAMPLEで充分
(setq org-export-with-fixed-width nil)
;;; ^と_を解釈しない
(setq org-export-with-sub-superscripts nil)
;;; --や---をそのまま出力する
(setq org-export-with-special-strings nil)
;;;tex, latexのコードを解釈しない
(setq org-export-with-LaTex-fragments nil)
(setq org-export-with-Tex-macros nil)
;;;改行を反映する
;;;(setq org-export-preserve-breaks t)

;;org-remember
(org-remember-insinuate)
(setq org-directory "~/Dropbox/memo")
(setq org-default-notes-file (expand-file-name "memo.org" org-directory))
(setq org-remember-templates
      '(("Note" ?n "** %?\n  %i\n  %a\n  %t" nil "Inbox")
        ("Todo" ?t "** TODO %?\n %in %a\n %t" nil "Inbox")))
(global-set-key (kbd "C-c r") 'org-remember)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c l") 'org-store-link)


;;org-todo
(setq org-use-fast-todo-selection t)
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(x)" "CANCEL(c)")
        (sequence "APPT(a)" "|" "DONE(x)" "CANCELc(c)")))
;;org-agenda
(setq org-agenda-files (list org-default-notes-file))
(global-set-key (kbd "C-c a") 'org-agenda)
;;org for publishing
(add-to-list 'load-path  "~/Dropbox/.emacs.d/org2blog/")
(require 'org2blog-autoloads)
(setq org2blog/wp-blog-alist
      '(("wp"
         :url "http://wp.slash-reader.com/xmlrpc.php"
         :username "admin"
         :password "dsdrpnkbki"
        )))
;;org-mod unset key binding
(define-key org-mode-map (kbd "C-,") nil)
(define-key org-mode-map (kbd "C-.") nil)
(define-key org-mode-map (kbd "C-,") 'beginning-of-buffer)
(define-key org-mode-map (kbd "C-.") 'end-of-buffer)


;; untilities
(setq x-select-enable-clipboard t)
;; デフォルトのinit.elの末尾に追加
;; My Settings for gnupack {{{1
(global-set-key [?\C-\;] 'undo)
(global-set-key [f12] 'uncomment-region)
(global-set-key [f11] 'comment-region)


;; ------------------------------------------------------------------------
;;; @ modeline
;;; 行番号の表示
(line-number-mode 1)
;;; 列番号の表示
(column-number-mode t)
;;; 時刻の表示
   (require 'time)
   (setq display-time-24hr-format t)
   (setq display-time-string-forms '(24-hours ":" minutes))
   (display-time-mode t)
;;; cp932エンコード時の表示を「P」とする
   (coding-system-put 'cp932 :mnemonic ?P)
   (coding-system-put 'cp932-dos :mnemonic ?P)
   (coding-system-put 'cp932-unix :mnemonic ?P)
   (coding-system-put 'cp932-mac :mnemonic ?P)

;; ------------------------------------------------------------------------
;;; @ cursor
;;; カーソル点滅表示
(blink-cursor-mode 0)

;;; スクロール時のカーソル位置の維持
(setq scroll-preserve-screen-position t)

;; スクロール行数（一行ごとのスクロール）
(setq vertical-centering-font-regexp ".*")
(setq scroll-conservatively 35)
(setq scroll-margin 0)
(setq scroll-step 1)

;; 画面スクロール時の重複行数
(setq next-screen-context-lines 1)

;; ------------------------------------------------------------------------
;; @ default setting

;;; 起動メッセージの非表示
(setq inhibit-startup-message t)

;;; スタートアップ時のエコー領域メッセージの非表示
(setq inhibit-startup-echo-area-message -1)

;; ------------------------------------------------------------------------
;; @ backup

   ;; 変更ファイルのバックアップ
   (setq make-backup-files nil)

   ;; 変更ファイルの番号つきバックアップ
   (setq version-control nil)

   ;; 編集中ファイルのバックアップ
   (setq auto-save-list-file-name nil)
   (setq auto-save-list-file-prefix nil)

   ;; 編集中ファイルのバックアップ先
   (setq auto-save-file-name-transforms
         `((".*" ,temporary-file-directory t)))

   ;; 編集中ファイルのバックアップ間隔（秒）
   (setq auto-save-timeout 30)

   ;; 編集中ファイルのバックアップ間隔（打鍵）
   (setq auto-save-interval 500)

   ;; バックアップ世代数
   (setq kept-old-versions 1)
   (setq kept-new-versions 2)

   ;; 上書き時の警告表示
   ;- (setq trim-versions-without-asking nil)

   ;; 古いバックアップファイルの削除
   (setq delete-old-versions t)

;; ------------------------------------------------------------------------
;; @ scroll

   ;; バッファの先頭までスクロールアップ
   (defadvice scroll-up (around scroll-up-around)
     (interactive)
     (let* ( (start_num (+ 1 (count-lines (point-min) (point))) ) )
       (goto-char (point-max))
       (let* ( (end_num (+ 1 (count-lines (point-min) (point))) ) )
         (goto-line start_num )
         (let* ( (limit_num (- (- end_num start_num) (window-height)) ))
           (if (< (- (- end_num start_num) (window-height)) 0)
               (goto-char (point-max))
             ad-do-it)) )) )
   (ad-activate 'scroll-up)

   ;; バッファの最後までスクロールダウン
   (defadvice scroll-down (around scroll-down-around)
     (interactive)
     (let* ( (start_num (+ 1 (count-lines (point-min) (point)))) )
       (if (< start_num (window-height))
           (goto-char (point-min))
         ad-do-it) ))
   (ad-activate 'scroll-down)





(add-hook 'dired-load-hook (function (lambda () (load "dired-x"))))
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(push '(dired-mode :position top) popwin:special-display-config)


(require 'moccur-edit)


;; 試行錯誤用
(require 'open-junk-file)
;C-x C-zで試行錯誤用ファイルを開く
(global-set-key (kbd "C-x C-z") 'open-junk-file)
;;;式の評価結果を注釈する
(require 'lispxmp)
;;emacs-lisp-modeでC-c C-dを押すと注釈される　 ;;M-; M-; で 注釈
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)
(defun lisp-xmp-comment-toggle ()
  (interactive)
  (save-excursion
    (if (re-search-forward "; *=>.*" (+ (line-end-position) 1) t 1)
	(replace-match "")
      (end-of-line)(insert " ; =>"))))
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'lisp-xmp-comment-toggle)
;;カッコの対応を保持して編集する設定
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(require 'auto-async-byte-compile)
;;自動コンパイルを無効にするファイル名の正規表現
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
(add-hook 'emacs-lisp-mode-hook  'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2) ;;すぐに表示しない
(setq eldoc-minor-mode-string "") ;; モードラインにElDocと表示しない
;; 釣り合いのとれるカッコをハイライトする
(show-paren-mode 1)
;;改行と同時にインデントも行う
(global-set-key "\C-m" 'newline-and-indent)
;; find-functionキーを割り当てる
(find-function-setup-keys)

;;dired-x, omit some type of files
(add-hook 'dired-load-hook (lambda ()
                             (load "dired-x")
                             (setq dired-omit-files-p t)
                             (dired-omit-mode 1)))

;;;;encodigの勉強 2011/12/24 rubikitchのメルマガ
;;(modify-coding-system-alist 'file "test.txt" 'euc-jp)
;;(progn
;;  (delete-file "~/tmp/test.txt")
;;  (modify-coding-system-alist 'file  "test.txt" nil)
;;)
(require 'dired-filetype-face)

;;for ediff
;;http://www.tokuda.net/diary/20070508
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)


(require 'calfw)
(add-hook 'calendar-load-hook
          (lambda ()
            (require 'japanese-holidays)
            (setq calendar-holidays
                  (append japanese-holidays local-holidays other-holidays))))
(setq  google-calendar-url  "https://www.google.com/calendar/ical/kimiyuki%40gmail.com/private-023e270bbbaf68a5495219ff44537b22/basic.ics")
(require 'calfw-ical)
(defun open-my-ical ()
  (interactive)
  (cfw:open-ical-calendar google-calendar-url))

;;;(add-to-list 'load-path "~/Dropbox/.emacs.d/auto-install/ess-knitr.el")
(require 'ess-knitr)


(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

;;; yasnippet
;;(require 'yasnippet)
(add-to-list 'load-path "~/Dropbox/.emacs.d/plugins")
(require 'yasnippet-bundle)
(yas/initialize)
(setq yas/root-directory  "~/Dropbox/.emacs.d/snippets")
(yas/load-directory yas/root-directory)
(require 'yasnippet-config)
(require 'dropdown-list)
(yas/global-mode 1)
(call-interactively 'yas/reload-all);workaround
;;;anything-complete.elを使っているなら yas/completing-prompt のみでもよい
(setq yas/prompt-functions '(yas/dropdown-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))

;; 現在行をハイライト
(global-hl-line-mode 1)

;; grepで編集OK
(require 'wgrep)
(setq wgrep-enable-key "r")

;; キーの二度押しなどをコマンドに
(require 'key-chord)
(setq key-chord-two-keys-delay 0.04)
(key-chord-mode 1)


;; 文字、単語選択
(require 'thing-opt)
(define-thing-commands)
(key-chord-define-global "ii" 'mark-word*)
(key-chord-define-global "st" 'mark-string)
(key-chord-define-global "ss" 'mark-sentence)

;;auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/Dropbox/.emacs.d/ac-dict")
;;(ac-config-default)
(global-auto-complete-mode t)


;;;; python
(add-to-list 'load-path "/usr/share/emacs/site-lisp/python-mode/")
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (setq py-shell-name "/usr/local/bin/ipython")
;; (setq ipython-command "/usr/local/bin/ipython")
;; (setq py-python-command "/usr/local/bin/ipython")

(require 'ac-python)
(add-to-list 'ac-modes 'python-2-mode)
