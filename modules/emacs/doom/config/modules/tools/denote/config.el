;;; config.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Luis Dale Gascon
;;
;; Author: Luis Dale Gascon <luis.gcodes@gmail.com>
;; Maintainer: Luis Dale Gascon <luis.gcodes@gmail.com>
;; Created: July 23, 2025
;; Modified: July 23, 2025
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/curlyLasagna/config
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(use-package! denote
  :hook (dired-mode . denote-dired-mode)
  :config
  (map! :leader
        :desc "Open or create note"         :n "d n" #'denote-open-or-create
        :desc "Link or create"              :n "d l" #'denote-link-or-create
        :desc "Rename file"                 :n "d r" #'denote-rename-file
        :desc "Grep notes"                  :n "d g" #'denote-grep
        :desc "Dired view"                  :n "d d" #'denote-dired)
  (setq! denote-date-prompt-use-org-read-date t)
  (denote-rename-buffer-mode 1))

(use-package! denote-journal
  :hook (calendar-mode . denote-journal-calendar-mode)
  :config
  (setq! denote-journal-directory (expand-file-name "journal" denote-directory))
  (map! :leader
        :desc "New or existing journal entry" :n "d j n" #'denote-journal-new-or-existing-entry
        :desc "Link or create journal entry"  :n "d j l" #'denote-journal-link-or-create-entry))


(provide 'config)
;;; config.el ends here
