(setq user-emacs-directory (expand-file-name "~/.config/minimal-emacs/"))
(setq package-user-dir (expand-file-name "elpa/" user-emacs-directory))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache (expand-file-name "eln-cache/" user-emacs-directory)))

(use-package use-package
  :custom
  (use-package-always-ensure t)
  (package-native-compile nil))


(use-package exec-path-from-shell
  ; Only apply to macOS
  :if (and (or (display-graphic-p) (daemonp))
           (eq system-type 'darwin)) 
  :demand t
  :functions exec-path-from-shell-initialize
  :config
  (exec-path-from-shell-initialize))

(setq native-comp-jit-compilation t)
(setq native-comp-async-report-warnings-errors nil)

;; Auto-revert in Emacs is a feature that automatically updates the
;; contents of a buffer to reflect changes made to the underlying file
;; on disk.
(use-package autorevert
  :ensure nil
  :commands (auto-revert-mode global-auto-revert-mode)
  :hook
  (after-init . global-auto-revert-mode)
  :init
  (setq auto-revert-interval 3)
  (setq auto-revert-remote-files nil)
  (setq auto-revert-use-notify t)
  (setq auto-revert-avoid-polling nil))

;; Recentf is an Emacs package that maintains a list of recently
;; accessed files, making it easier to reopen files you have worked on
;; recently.
(use-package recentf
  :ensure nil
  :commands (recentf-mode recentf-cleanup)
  :hook
  (after-init . recentf-mode)

  :init
  (setq recentf-auto-cleanup (if (daemonp) 300 'never))
  (setq recentf-exclude
        (list "\\.tar$" "\\.tbz2$" "\\.tbz$" "\\.tgz$" "\\.bz2$"
              "\\.bz$" "\\.gz$" "\\.gzip$" "\\.xz$" "\\.zip$"
              "\\.7z$" "\\.rar$"
              "COMMIT_EDITMSG\\'"
              "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
              "-autoloads\\.el$" "autoload\\.el$"))

  :config
  ;; A cleanup depth of -90 ensures that `recentf-cleanup' runs before
  ;; `recentf-save-list', allowing stale entries to be removed before the list
  ;; is saved by `recentf-save-list', which is automatically added to
  ;; `kill-emacs-hook' by `recentf-mode'.
  (add-hook 'kill-emacs-hook #'recentf-cleanup -90))

;; savehist is an Emacs feature that preserves the minibuffer history between
;; sessions. It saves the history of inputs in the minibuffer, such as commands,
;; search strings, and other prompts, to a file. This allows users to retain
;; their minibuffer history across Emacs restarts.
(use-package savehist
  :ensure nil
  :commands (savehist-mode savehist-save)
  :hook
  (after-init . savehist-mode)
  :init
  (setq history-length 300)
  (setq savehist-autosave-interval 600))

;; Corfu enhances in-buffer completion by displaying a compact popup with
;; current candidates, positioned either below or above the point. Candidates
;; can be selected by navigating up or down.
(use-package corfu
  :commands (corfu-mode global-corfu-mode)

  :hook ((prog-mode . corfu-mode)
         (shell-mode . corfu-mode)
         (eshell-mode . corfu-mode))

  :custom
  ;; Hide commands in M-x which do not apply to the current mode.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Disable Ispell completion function. As an alternative try `cape-dict'.
  (text-mode-ispell-word-completion nil)
  (tab-always-indent 'complete)

  ;; Enable Corfu
  :config
  (global-corfu-mode))

;; Cape, or Completion At Point Extensions, extends the capabilities of
;; in-buffer completion. It integrates with Corfu or the default completion UI,
;; by providing additional backends through completion-at-point-functions.
(use-package cape
  :commands (cape-dabbrev cape-file cape-elisp-block)
                                        ; :bind ("C-c p" . cape-prefix-map)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file))

;; The undo-fu package is a lightweight wrapper around Emacs' built-in undo
;; system, providing more convenient undo/redo functionality.
(use-package undo-fu
  :commands (undo-fu-only-undo
             undo-fu-only-redo
             undo-fu-only-redo-all
             undo-fu-disable-checkpoint))
                                        ; :config
                                        ; (global-unset-key (kbd "C-z"))

;; The undo-fu-session package complements undo-fu by enabling the saving
;; and restoration of undo history across Emacs sessions, even after restarting.
(use-package undo-fu-session
  :commands undo-fu-session-global-mode
  :hook (after-init . undo-fu-session-global-mode))

;; The markdown-mode package provides a major mode for Emacs for syntax
;; highlighting, editing commands, and preview support for Markdown documents.
;; It supports core Markdown syntax as well as extensions like GitHub Flavored
;; Markdown (GFM).
(use-package markdown-mode
  :commands (gfm-mode
             gfm-view-mode
             markdown-mode
             markdown-view-mode)
  :mode (("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode)))

;; Org mode is a major mode designed for organizing notes, planning, task
;; management, and authoring documents using plain text with a simple and
;; expressive markup syntax. It supports hierarchical outlines, TODO lists,
;; scheduling, deadlines, time tracking, and exporting to multiple formats
;; including HTML, LaTeX, PDF, and Markdown.
(use-package org
  :commands (org-mode org-version)
  :mode
  ("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode)
  :config
  (setq +org-capture-journal-file (expand-file-name "journal.org" org-directory))
  (setq +org-capture-projects-file (expand-file-name "projects.org" org-directory))
  :custom
  (org-hide-leading-stars t)
  (org-startup-indented t)
  (org-adapt-indentation nil)
  (org-edit-src-content-indentation 0)
  (org-indent-mode 1)
  (org-fontify-todo-headline t)
  (org-fontify-quote-and-verse-blocks t)
  (org-startup-truncated t)
  (org-directory (expand-file-name "~/Documents/org"))

  (org-capture-templates
        ;; Vanilla org is used for project, journals and meetings
        '(
          ("j" "Journal")
          ("jn" "Journal" entry
           (file+olp+datetree +org-capture-journal-file)
           "* %<%I:%M %p>\n%?" :prepend t :tree-type (year month day)
           )

          ("jd" "Journal on date" entry
           (file+olp+datetree +org-capture-journal-file)
           "* %<%I:%M %p>\n%?"
           :prepend t :time-prompt t :tree-type (year month day)
           )

          ("jw" "Work log" entry
           (file+olp+datetree "work-log.org")
           "* %?" :clock-in t :clock-keep t :tree-type (year month week day)
           )

          ("p" "Projects")
          ("pN" "New project" entry
           (file +org-capture-projects-file)
           "* %^{Project Name}\n** Tasks\n** Notes")
          ("pt" "Project todo" entry
           (function my/org-capture-select-project-target)
           "* TODO %? %i"
           :subheading "Tasks"
           :prepend nil)

          ("pn" "Project notes" entry
           (function my/org-capture-select-project-target)
           "* %? %i"
           :subheading "Notes"
           :prepend t)
          )
        )
  (org-todo-keywords
   '(
          ;; Project todos
          (sequence "TODO" "WIP" "DONE")
          ;; Note-taking todos
          (sequence "INBOX(i)"
	            "PROCESSING(p)"
	            "WAIT(w)"
	            "TO-READ(r)"
	            "|"
	            "DONE(d)"
	            ))
   )
  )

(use-package elec-pair
  :ensure nil
  :commands (electric-pair-mode
             electric-pair-local-mode
             electric-pair-delete-pair)
  :hook (after-init . electric-pair-mode))

(use-package nix-mode
  :commands nix-mode
  :mode ("\\.nix\\'" . nix-mode))

(use-package no-littering
  :init
  (eval-and-compile
    (setq no-littering-etc-directory
          (expand-file-name "etc/" "~/.config/minimal-emacs/"))
    (setq no-littering-var-directory
          (expand-file-name "var/" "~/.config/minimal-emacs/")))
  :config
  (no-littering-theme-backups))

(use-package consult
  :bind (
         ("C-x b" . consult-buffer)
         ("M-y"   . consult-yank-from-kill-ring)
         ("C-c s i" . consult-imenu)
         )
  )

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  (
   (dired-mode . hl-line-mode)
  )
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-kill-when-opening-new-dired-buffer t)
  (setq dired-dwim-target t))

(use-package dired-subtree
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  ;; Do fuzzy search by adding orderless-flex to the list.
  (orderless-matching-styles '(orderless-literal orderless-regexp))
  ;; Get orderless everywhere
  (completion-category-defaults nil)
  (completion-category-overrides
   ;; from Emacs Writing Studio & Corfu README
   '((file (styles partial-completion)))))

(use-package dumb-jump
  :hook (xref-backend-functions . dumb-jump-xref-activate)
  :custom
  ;; use consult instead of pop-up buffer
  (xref-show-definitions-function 'xref-show-definitions-completing-read)
  )

(use-package magit
  :custom
  ;; Improve readability of diffs
  (magit-diff-refine-hunk 'all)
  )

(use-package auto-dark
  :custom
  (auto-dark-themes '((modus-vivendi-tinted) (modus-operandi-tinted)))
  :config
  (auto-dark-mode))

(defun prot/keyboard-quit-dwim ()
  "Do-What-I-Mean behaviour for a general `keyboard-quit'.

  The generic `keyboard-quit' does not do the expected thing when
  the minibuffer is open.  Whereas we want it to close the
  minibuffer, even without explicitly focusing it.

  The DWIM behaviour of this command is as follows:

  - When the region is active, disable it.
  - When a minibuffer is open, but not focused, close the minibuffer.
  - When the Completions buffer is selected, close it.
  - In every other case use the regular `keyboard-quit'."
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

(global-set-key [remap keyboard-quit] 'prot/keyboard-quit-dwim)

(use-package stripspace
  ;; Enable for prog-mode-hook, text-mode-hook, conf-mode-hook
  :hook ((prog-mode . stripspace-local-mode)
         (text-mode . stripspace-local-mode)
         (conf-mode . stripspace-local-mode))

  :custom
  ;; The `stripspace-only-if-initially-clean' option:
  ;; - nil to always delete trailing whitespace.
  ;; - Non-nil to only delete whitespace when the buffer is clean initially.
  ;; (The initial cleanliness check is performed when `stripspace-local-mode'
  ;; is enabled.)
  (stripspace-only-if-initially-clean nil)

  ;; Enabling `stripspace-restore-column' preserves the cursor's column position
  ;; even after stripping spaces. This is useful in scenarios where you add
  ;; extra spaces and then save the file. Although the spaces are removed in the
  ;; saved file, the cursor remains in the same position, ensuring a consistent
  ;; editing experience without affecting cursor placement.
  (stripspace-restore-column t))

(use-package denote
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-grep))
  :config
  (setq denote-directory (expand-file-name "denotes" org-directory))
  (denote-rename-buffer-mode 1))

(defun indent-whole-buffer ()
  "Indent the entire buffer without affecting point or mark."
  (interactive)
  (save-excursion
    (save-restriction
      (indent-region (point-min) (point-max)))))

(add-hook 'after-init-hook #'global-auto-revert-mode)
(add-hook 'after-init-hook #'recentf-mode)
(add-hook 'after-init-hook #'savehist-mode)
(add-hook 'after-init-hook #'save-place-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(setq display-line-numbers-type 'relative)
(setq display-line-numbers-width 3)
(delete-selection-mode 1)
(setq line-number-mode t)
(setq confirm-kill-emacs 'y-or-n-p)
(setq truncate-string-ellipsis "…")
(flymake-mode 1)

(set-face-attribute 'default nil :height 140)
