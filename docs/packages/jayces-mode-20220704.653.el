;;; jayces-mode.el --- Major mode for editing JayCeS file  -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Shen, Jen-Chieh
;; Created date 2018-10-11 16:28:04

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/jcs-elpa/jayces-mode
;; Package-Version: 20220704.653
;; Package-Commit: 719b140ea1cf1a8b15046c85cca4b2b818750754
;; Version: 0.0.2
;; Package-Requires: ((emacs "24.3"))
;; Keywords: lisp jayces

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Major mode for editing JayCeS file.
;;

;;; Code:

(eval-and-compile
  (require 'compile)
  (require 'cc-mode)
  (require 'font-lock)
  (require 'rx)
  (require 'newcomment))

(eval-when-compile
  (require 'cl-lib))

(defgroup jayces nil
  "Major mode for editing JayCeS file."
  :prefix "jayces-"
  :group 'languages
  :link '(url-link :tag "Repository" "https://github.com/jcs-elpa/jayces-mode"))

;;; Font Lock
(defconst jayces--font-lock-keywords
  '(("function" . font-lock-keyword-face))
  "Font lock keywords for `jayces-mode'.  See `font-lock-keywords'.")

;; define hook
(defcustom jayces-mode-hook nil
  "*Hook to be run when `jayces-mode' is entered."
  :type  'hook
  :group 'jayces)

(defvar jayces-mode-syntax-table
  (let ((table (make-syntax-table)))
    (c-populate-syntax-table table)
    (modify-syntax-entry ?$ "_" table)
    (modify-syntax-entry ?` "\"" table)
    table)
  "Syntax table for `jayces-mode'.")

;;;###autoload
(defun jayces-mode-smart-context-line-break ()
  "Comment block line break."
  (interactive))

;;;###autoload
(defun jayces-mode-c-comment-pair ()
  "Auto pair c style comment block."
  (interactive))

(defvar jayces-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "RET") #'jayces-mode-smart-context-line-break)
    (define-key map (kbd "*") #'jayces-mode-c-comment-pair)
    map)
  "Kaymap for `jayces-mode'.")

;; The main mode functions
;;;###autoload
(define-derived-mode jayces-mode prog-mode "JayCeS"
  "Major mode for editing JayCeS file."

  :group 'jayces
  :syntax-table jayces-mode-syntax-table

  (setq-local font-lock-defaults (list jayces--font-lock-keywords))

  ;; Comments
  (setq-local comment-start "// ")
  (setq-local comment-end "")

  ;; for filling, pretend we're cc-mode
  (setq c-comment-prefix-regexp "//+\\|\\**"
        c-paragraph-start "$"
        c-paragraph-separate "$"
        c-block-comment-prefix "* "
        c-line-comment-starter "//"
        c-comment-start-regexp "/[*/]\\|\\s!"
        comment-start-skip "\\(//+\\|/\\*+\\)\\s *")

  (let ((c-buffer-is-cc-mode t))
    (make-local-variable 'paragraph-start)
    (make-local-variable 'paragraph-separate)
    (make-local-variable 'paragraph-ignore-fill-prefix)
    (make-local-variable 'adaptive-fill-mode)
    (make-local-variable 'adaptive-fill-regexp)
    (c-setup-paragraph-variables))

  ;; bind keymap
  (use-local-map jayces-mode-map))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.jcs'?\\'" . jayces-mode))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.jayces'?\\'" . jayces-mode))

(provide 'jayces-mode)
;;; jayces-mode.el ends here
