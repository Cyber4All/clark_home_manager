;;; packages.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Luis Dale Gascon
;;
;; Author: Luis Dale Gascon <luis.gcodes@gmail.com>
;; Maintainer: Luis Dale Gascon <luis.gcodes@gmail.com>
;; Created: December 13, 2025
;; Modified: December 13, 2025
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/curlyLasagna/packages
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(package! typst-ts-mode)
(package! typst-preview
  :recipe (:host github :repo "havarddj/typst-preview.el"))


(provide 'packages)
;;; packages.el ends here
