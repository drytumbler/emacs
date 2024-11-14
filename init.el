;; ~/.emacs.d/init.el  -*- lexical-binding: t; eval: (local-set-key (kbd "C-c i") #'consult-outline); outline-regexp: ";;;"; -*-

;;; startup: ;;;
(setq gc-cons-threshold (* 10 1000 1000))
(add-hook 'emacs-startup-hook
	  #'(lambda ()
		    (message "Startup took %s sec with %d garbage collections.."
			     (emacs-init-time "%.2f")
			     gcs-done)))

 (require 'server)
(unless (server-running-p)
  (server-start))

;;; lsp-performance
(setq read-process-output-max (* 1024 1024))

;;; install straight: ;;;

;; (If raw.githubusercontent.com is blocked by your ISP, try replacing the URL with https://radian-software.github.io/straight.el/install.el. Or you can clone straight.el manually to ~/.emacs.d/straight/repos/straight.el.)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq package-enable-at-startup nil)

;;; add melpa to package-list-packages
;;(require 'package)
;;(add-to-list 'package-archives
;;	     '("melpa" . "https://melpa.org/packages/"))



;;; global setup

(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs-saves/"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

;;set autosave and backups
(setq make-backup-file t)
(setq auto-save-default t)



(defalias 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)

;;; pandoc
(straight-use-package 'pandoc)

;;; htmlize
(straight-use-package 'htmlize)

;;; colors - rainbow-mode
;;rainbow displays hex colors 
(use-package rainbow-mode
  :ensure t
  :init
    (add-hook 'prog-mode-hook 'rainbow-mode)) 

 (use-package rainbow-delimiters
    :ensure t
    :init
      (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;;; auctex
(use-package auctex
  :ensure t
  :after org
  :hook
  (LaTeX-mode . turn-on-prettify-symbols-mode)
					;(LaTeX-mode . turn-on-flyspell)
  )

(use-package cc-mode
  :ensure t
  )

;; LSP for C++ support
(use-package lsp-mode
  :straight t
  :hook ((c++-mode . lsp)
         (c-mode . lsp))
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil)) ;; Use flycheck instead of flymake

;; Optional: UI features for LSP
(use-package lsp-ui
  :straight t
  :commands lsp-ui-mode)

(use-package flycheck
  :straight t
  :init (global-flycheck-mode))

;; CMake Mode for syntax highlighting and indentation
(use-package cmake-mode
  :straight t
  :mode ("CMakeLists\\.txt\\'" . cmake-mode)
  :config
  (setq cmake-tab-width 4))

;; CMake IDE for automatic project configuration and building
(use-package cmake-ide
  :straight t
  :hook ((c-mode . cmake-ide-setup)
         (c++-mode . cmake-ide-setup))
  :config
  ;; Set the default CMake build directory
  (setq cmake-ide-build-dir "build")
  (setq cmake-ide-cmake-opts "-DCMAKE_BUILD_TYPE=Debug"))

(defun my-cmake-compile-command ()
  "Set the compilation command for a CMake project."
  (set (make-local-variable 'compile-command)
       "cmake -S .. -B build -DCMAKE_BUILD_TYPE=Debug && cmake --build build"))

(add-hook 'c++-mode-hook 'my-cmake-compile-command)


(use-package lua-mode
  :ensure t
  )

;;; latex-extra ??
;;(use-package latex-extra
;;  :config (add-hook 'LaTeX-mode-hook #'latex-extra-mode))



;;; bibtex-capf ??
(straight-use-package 'bibtex-capf)

;;; htmlize
(straight-use-package 'htmlize)

;;; glsl-mode
(use-package glsl-mode
  :ensure t)


;;; which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

;;; undo-tree
(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history nil))

;;; treesit-auto
(use-package treesit-auto
  :config
  (setq treesit-auto-langs
	'(awk bash c c-sharp cmake commonlisp cpp css dockerfile glsl html java javascript json lua make org perl python sql toml typescript wgsl))
  (treesit-auto-install-all)
  ;; (treesit-auto-add-to-auto-mode-alist 'all)
  (setq treesit-auto-install 'prompt))

;;; vertico
(use-package vertico
  :ensure t
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  (vertico-mode 1))


;;; marginalia
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

;;; orderless
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

;;; consult
(use-package consult
  :ensure t
  :bind (;; A recursive grep
	 ("M-s M-g" . consult-grep)
	 ;; Search for files recursively
	 ("M-s M-f" . consult-find)
	 ;; Search the outline of the file
	 ("M-s M-o" . consult-outline)
	 ;; Search the current buffer
	 ("M-s M-l" . consult-line)
	 ;; Consult buffer
	 ("C-x b" . consult-buffer)
	 ))

;;; embark
(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
	 :map minibuffer-local-map
	 ("C-c C-c" . embark-collect)
	 ("C-c C-e" . embark-export)))

;;; embark-consult
(use-package embark-consult
  :ensure t)

;;; wgrep
(use-package wgrep
  :ensure t
  :bind ( :map grep-mode-map
	  ("e" . wgrep-change-wgrep-mode)
	  ("C-x C-q" . wgrep-change-to-wgrep-mode)
	  ("C-c C-c" . wgrep-finish-edit)))

;;; corfu
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode 1)
  :custom
  (corfu-auto t)                ;; Enable auto completion
  (corfu-cycle t)               ;; Enable cycling for `corfu-next/previous'
  (corfu-separator ?\s)         ;; Orderless field separator
  (corfu-quit-at-boundary t)    ;; Never quit at completion boundary
  (corfu-quit-no-match t)       ;; Quit if there is no match
  (corfu-preview-current nil)   ;; Disable current candidate preview
  (corfu-preselect-first nil))  ;; Disable candidate preselection


;;; eglot
;;; cape
;;; orderless

;;; org-make-toc
;;(use-package org-make-toc
;;  :config
;;  (setq org-make-toc-insert-custom-ids t))


;;; mu4e
;;use-package mu4e

;;; basic / gui / interface
;; turn-offs
(setq inhibit-startup-message t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;;turn-ons
(savehist-mode 1)
(recentf-mode 1)

(when window-system (global-prettify-symbols-mode 1))

;;; completion built-in
;;(setq completion-auto-select 'second-tab)
;;(setq completion-auto-help 'visible)
;;(setq completions-max-height 12)

;;; theme

(load-theme 'dark-night t)

;;; org-mode

(setq my-todo-file "~/planning.org"
      my-schd-file "~/schedule.org")


;; General Org Mode settings
(setq org-startup-indented t
      org-startup-truncated nil
      org-hide-emphasis-markers t
      org-list-allow-alphabetical t
      org-duration-format '(special . h:mm)   ;; Display time in hours and minutes
      org-image-actual-width nil              ;; Display images at full width
      org-html-validation-link nil            ;; Remove validation link from HTML export
      org-export-with-toc nil                 ;; No table of contents in exports
      org-refile-targets '((nil :level . 1)   ;; Refile targets for TODOs
                           (nil :level . 2)))
(setq org-tag-alist
      '((:startgroup)
        ("@work" . ?w)     ; Use 'w' as a shortcut
        ("@home" . ?h)     ; 'h' for home-related tasks
        ("@band" . ?b)     ; 'b' for band/music-related tasks
        (:endgroup)
        ("daily" . ?d)     ; 'd' for tasks that are daily routines
        ("weekly" . ?W)    ; 'W' for weekly routines
        ("exercise" . ?e)  ; 'e' for exercise-related tasks
        ("study" . ?s)     ; 's' for studying or learning
        ("project" . ?p))) ; 'p' for ongoing projects


;; Global Keybindings for Org Mode
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Lazy loading `use-package` blocks for deferred initialization of modules
(use-package org
  :ensure t
  :mode ("\\.org\\'" . org-mode)
  ;; :init
  ;; (setq org-agenda-files (list my-todo-file my-schd-file))
  :config
  (require 'ox-latex)
  (defun add-org-latex-class (class-name class-definition)
    "Helper function to add LaTeX class to org-latex-classes."
    (add-to-list 'org-latex-classes
                 (list class-name class-definition
                       '("\\chapter{%s}" . "\\chapter*{%s}")
                       '("\\section{%s}" . "\\section*{%s}")
                       '("\\subsection{%s}" . "\\subsection*{%s}")
                       '("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

  (add-org-latex-class "standalone" "\\documentclass{standalone}")
  (add-org-latex-class "memoir" "\\documentclass{memoir}")
  (add-org-latex-class "beamer" "\\documentclass{beamer}")


  ;; Agenda setup
  (setq org-agenda-span 14
        org-agenda-start-on-weekday nil
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-show-all-dates t
        org-deadline-warning-days 7
        org-agenda-custom-commands
        '(("c" "Simple agenda view" ((agenda "") (alltodo "")))
          ("d" "Upcoming deadlines" ((agenda "" ((org-deadline-warning-days 14)))))))
  ;; Set the date format to European style (day-month-year)
  (setq calendar-date-style 'european)

  ;; Ensure Org mode uses the same date format
  (setq org-agenda-time-grid '((daily today require-timed) 
                              (16 10 2 1)))

  (setq org-agenda-start-on-weekday 1)  ; Start week on Monday
  (setq org-agenda-weekend-days '(0 6))  ; Keep Saturday and Sunday visible
  
  ;; Ensure org-clock uses the same date format
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate)
  
  (setq org-clock-out-remove-zero-time-clocks t)
  
  ;; Change the time format if you want to display it in 24-hour format
  (setq display-time-24hr-format t)
  (setq display-time-format "%Y-%m-%d %H:%M")
  (display-time-mode 1)
  
  ;; Capture templates
  (setq org-capture-templates
        '(("t" "Todo" entry (file my-todo-file)
           "* TODO %?\n  %i\n  %a")
          ("p" "Planning" entry (file my-schd-file)
           "* %?\n  SCHEDULED: %t\n  %i\n  %a")
	  ("c" "Contact" plain (function org-capture-place-entry-here)
           "- %(read-string \"Name: \")\n  :PROPERTIES:\n  :Phone: %(read-string \"Phone: \")\n  :Email: %(read-string \"Email: \")\n  :Address: %(read-string \"Address: \")\n  :Birthday: %(read-string \"Birthday: \")\n  :END:\n%?")))

  ;; Function to capture template at point
(defun org-capture-place-entry-here ()
  "Insert capture entry at point."
  (or (and (eq major-mode 'org-mode) (point-marker))
      (user-error "Not in an Org-mode buffer")))


  ;; Pretty symbols for TODO keywords
  (setq org-todo-keywords
        '((sequence "☛ TODO" "✲ IN-PROGRESS" "$ BUSN.ORG" "|" "✔ DONE"))))

;; visual fill column minor mode
(straight-use-package 'visual-fill-column)
(add-hook 'org-mode-hook #'visual-line-mode)
(add-hook 'org-mode-hook #'visual-fill-column-mode)


;; Enhance readability with visual improvements
(use-package org-bullets
  :ensure t
  :config (setq org-bullets-bullet-list '("◉" "○" "►" "◆" "◘"))
  :hook (org-mode . org-bullets-mode))

;; Custom Agenda dynamic blocks
(defun org-dblock-write:agenda (params)
  "Insert agenda view as a dynamic block in Org file."
  (let ((org-agenda-span 'week)
        (org-deadline-warning-days 7))
    (org-agenda nil "a")))


(add-to-list 'auto-mode-alist '("\\.draft\\'" . org-mode))


;;; ide-magic

;; line-numbers
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; move-line-up
(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(defun quick-copy-line ()
  "Copy the whole line that point is on and move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
  
  (interactive)
  (let ((beg (line-beginning-position 1))
	(end (line-beginning-position 2)))
    (if (eq last-command 'quick-copy-line)
	(kill-append (buffer-substring beg end) (< end beg))
      (kill-new (buffer-substring beg end))))
  (beginning-of-line 2))

(defun copy-line-simple (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
  (interactive "p")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (when mark-active
      (if (> (point) (mark))
          (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
        (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
    (if (eq last-command 'copy-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-ring-save beg end)))
  (kill-append "\n" nil)
  (beginning-of-line (or (and arg (1+ arg)) 2))
  (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

(defun copy-line-down ()
  (interactive)
  (copy-line 1)
  (yank-in-context)
  (forward-line -1)
  )

(defun copy-line-up ()
  (interactive)
  (copy-line-simple 1)
  (forward-line)
  (yank-in-context)
  (forward-line -1)
  )

(global-set-key (kbd "M-<down>") 'move-line-down) 
(global-set-key (kbd "M-<up>") 'move-line-up) 
(global-set-key [(meta control w)] 'quick-copy-line)
(global-set-key [(meta control down)] 'copy-line-down)
(global-set-key [(meta control up)] 'copy-line-up)

(defvar my-control-start-string "\" ({")
(defvar my-control-end-string "\" )}")

(defun my-control-a ()
  (interactive)
  "Move point to first character of line _not_ in STRING"
  (progn
  (goto-char (line-beginning-position))
  (skip-chars-forward my-control-start-string)))
(global-set-key (kbd "C-ù") #'my-control-a)

(defun my-control-e ()
  (interactive)
  "Move point to last non-whitespace character of line"
  (progn
  (goto-char (line-end-position))
  (skip-chars-backward my-control-end-string)))
(global-set-key (kbd "C-µ") #'my-control-e)

(defun my-kill-line ()
  (interactive)
  "Kill whole line, moving point to the beginning of the line at the current indentation"
  (progn
    (goto-char (line-beginning-position))
    (skip-chars-forward " ")
    (kill-line)))
(global-set-key (kbd "C-%") #'my-kill-line)

(defun my-empty-brackets ()
  (interactive)
  (skip-chars-forward "^\n)(}{][\"") ;; move to cloasing bracket
  (while (not (or (equal (point) (pos-eol))
		  (equal (point) (pos-bol))
		  (looking-back "[][{}()\"]" )))
    (backward-delete-char 1)))
    
  (global-set-key (kbd "C-c $") #'my-empty-brackets)
;;; keybindings ;;;

;; terminal
(global-set-key (kbd "<M-s-return>") 'ansi-term)

;; C-c e - config-visit
(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-c e") 'config-visit)

;; C-c r - config reload
(defun config-reload ()
  "Reloads ~/.emacs.d/init.el at runtime"
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))
(global-set-key (kbd "C-c r") 'config-reload)


;; split-follow
  (defun split-and-follow-horizontally ()
    (interactive)
    (split-window-below)
    (balance-windows)
    (other-window 1))
  (keymap-global-set "C-x 2" 'split-and-follow-horizontally)

  (defun split-and-follow-vertically ()
    (interactive)
    (split-window-right)
    (balance-windows)
    (other-window 1))
(keymap-global-set "C-x 3" 'split-and-follow-vertically)

(defun pandoc-count-words ()
  (interactive)
  (shell-command-on-region (point-min) (point-max)
                           "pandoc --lua-filter wordcount.lua"))


;; Define a custom face
(defface my-custom-face
  '((t :foreground "grey" :weight regular))  ; Change 'red' and 'bold' to your desired style
  "A custom face for highlighting '0.0'.")

;; Add a font-lock rule to highlight '0.0'
(defun highlight-zero-zero ()
  (font-lock-add-keywords
   nil
   '(("\\b0\\.0\\b" . 'my-custom-face))))  ; Use '\\b' to match whole word

(add-hook 'prog-mode-hook 'highlight-zero-zero)  ; Apply to programming modes


;; Set the compile buffer to open at the bottom and shrink to 8 lines.
(add-to-list 'display-buffer-alist
             '("\\*compilation\\*"               ; Match the *compilation* buffer
               (display-buffer-reuse-window      ; Reuse or pop a window
                display-buffer-at-bottom)        ; Place at the bottom of the frame
               (window-height . 8)))             ; Set it to 8 lines high

;; Function to adjust compilation buffer based on exit status
(defun my-compilation-finish-function (buffer msg)
  "Adjust the compilation BUFFER window size based on exit MSG."
  (with-current-buffer buffer
    (let ((window (get-buffer-window buffer))
          (desired-height (if (string-match "exited abnormally" msg) 24 4))) ; Desired height based on error status
      (when window
        (with-selected-window window
	  (setq compilation-window-height desired-height)
          (compilation-set-window-height window)   ; Set the window height directly
          (if (string-match "Compilation finished" msg)
              (goto-char (point-max))      ; Scroll to the top if there are errors
            ()))))))    ; Scroll to the end of output if no errors

;; Add the function to the compilation finish hook
(add-hook 'compilation-finish-functions 'my-compilation-finish-function)

;; Enable auto-scrolling to the end of the output.
(setq compilation-scroll-output 'first-error)    ; Scroll to the end for errors
;; (setq compilation-scroll-output t)            ; Alternative: Always scroll to end



;; Mark //TODO in code:
;; Define a custom face for TODO comments
(defface my/todo-face
  '((t :foreground "orange" :weight bold))
  "Face for TODO comments.")

;; Add the font-lock rule for TODO comments in prog-mode
(defun my/highlight-todo-comments ()
  (font-lock-add-keywords nil
   '(("\\(//[ ]*#?TODO\\)" 1 'my/todo-face t))))

(add-hook 'prog-mode-hook 'my/highlight-todo-comments)

;; Mark // MARK in code
(defface my/mark-face
  '((t :foreground "dark green" :weight bold))
  "Face for MARK comments.")

;; Add the font-lock rule for TODO comments in prog-mode
(defun my/highlight-mark-comments ()
  (font-lock-add-keywords nil
   '(("\\(//[ ]*#?MARK\\)" 1 'my/mark-face t))))

(add-hook 'prog-mode-hook 'my/highlight-mark-comments)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-date-style 'european)
 '(calendar-offset -1)
 '(calendar-today-marker 'calendar-today)
 '(custom-safe-themes
   '("24a701e9692fd2dc1033a6130701730f692c65b98863e19dda8911ab9757eebc" "9703b312b7778b6f8402b7f0748597127fbd179176d9b7a0ac7f8e14e9457887" "4bfd7326f991e1c4860204fbb4baf94cccd70980749df4c93f10268df663be53" "1abefc4268ca85d974909d3b56285ba7460b75530a1b7071c16005d7093c1e12" "11d5eeda54cc780cbc1735adb8a7e7922382885bb322a84d3008061cbe2e8d2b" "986682b9524a45b6a0758d2f89f1357662eb0be371bce6fd23e4228857160689" "e10e19f65dc847c8fd1da0ad8f05c59aba8275597033febb0798d68f3eaa845f" default))
 '(org-agenda-files '("/home/ruben/planning.org" "/home/ruben/busn.org"))
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-doi ol-eww ol-gnus ol-info ol-irc ol-mhe ol-rmail org-tempo ol-w3m))
 '(org-read-date-force-compatible-dates t)
 '(org-read-date-prefer-future t)
 '(safe-local-variable-values
   '((eval local-set-key
	   (kbd "C-c i")
	   #'consult-outline)
     (eval time-stamp)
     (time-stamp-active . t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-today ((t (:inherit cursor :underline t)))))

(find-file (expand-file-name "welcome.org" user-emacs-directory))
