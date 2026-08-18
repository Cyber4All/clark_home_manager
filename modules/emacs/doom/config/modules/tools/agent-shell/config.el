;;; config.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2026 Luis Dale Gascon
;;
;; Author: Luis Dale Gascon <luis.gcodes@gmail.com>
;; Maintainer: Luis Dale Gascon <luis.gcodes@gmail.com>
;; Created: May 22, 2026
;; Modified: May 22, 2026
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/curlyLasagna/config
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;

(require 'acp)
(require 'agent-shell)

(use-package! agent-shell
  :bind (:map agent-shell-mode-map
              ("RET" . newline)
              ("C-c C-c" . shell-maker-submit)
              ("C-c C-k" . agent-shell-interrupt))
  :config
  (setq agent-shell-display-action nil)
  (setq agent-shell-context-sources nil)
  ;; Dock agent-shell on the left
  (set-popup-rule!
    (lambda (bname _action)
      (and (display-graphic-p)
           (let ((buf (get-buffer bname)))
             (and buf
                  (with-current-buffer buf
                    (derived-mode-p 'agent-shell-mode))))))
    :select t
    :size 0.3
    :quit nil
    :side 'left
    :ttl nil))


(provide 'config)
