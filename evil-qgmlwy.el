;;; evil-qgmlwy.el --- Basic qgmlwy key bindings for evil-mode

;; Author: Wouter Bolsterlee, Árni Dagur <arni@dagur.eu>
;; Version: 1.0.0
;; Package-Requires: ((emacs "24") (evil "1.2.12") (evil-snipe "2.0.3"))
;; Keywords: qgmlwy evil
;; URL: https://github.com/ArniDagur/evil-qgmlwy
;;
;; This file is not a part of GNU Emacs.

;;; License:

;; Licensed under the terms of the GNU General Public License 3.0 or above

;;; Code:

(require 'evil)
(require 'evil-snipe)

(defgroup evil-qgmlwy nil
  "Basic key rebindings for evil-mode with the QGMLWY keyboard layout."
  :prefix "evil-qgmlwy-"
  :group 'evil)

(defcustom evil-qgmlwy-use-snipe t
  "Whether to use evil-snipe for find/look and `till"
  :group 'evil-qgmlwy
  :type 'boolean)

(defun evil-qgmlwy--make-keymap ()
  "Initialise the keymap baset on the current configuration."
  (let ((keymap (make-sparse-keymap)))
    (evil-define-key '(motion normal visual) keymap
      "u" 'evil-previous-visual-line
      "e" 'evil-next-visual-line
      "a" 'evil-backward-char
      "o" 'evil-forward-char
      "f" 'evil-backward-word-begin
      "b" 'evil-forward-word-begin
      "F" 'evil-beginning-of-line
      "B" 'evil-end-of-line)
    (evil-define-key '(normal visual) keymap
      "w" 'undo-tree-undo
    (evil-define-key 'normal keymap
      (kbd "M-u") 'evil-open-above
      (kbd "M-e") 'evil-open-below
      (kbd "M-a") 'evil-insert
      (kbd "M-o") 'evil-append
      (kbd "M-f") 'evil-insert-line
      (kbd "M-b") 'evil-append-line)
    (evil-define-key 'visual keymap
      (kbd "M-a") 'evil-insert)
    (evil-define-key 'operator keymap
      "o" 'evil-forward-char)
    (if evil-qgmlwy-use-snipe
      (evil-define-key '(motion normal visual) keymap
          "l" 'evil-find-char
          "L" 'evil-find-char-backward
          "t" 'evil-find-char-to
          "T" 'evil-find-char-to-backward)
     (;; XXX https://github.com/hlissner/evil-snipe/issues/46
      (evil-snipe-def 1 inclusive "t" "T")
      (evil-snipe-def 1 exclusive "j" "J")
      (evil-define-key '(motion normal visual) keymap
        "l" 'evil-snipe-t
        "L" 'evil-snipe-T
        "t" 'evil-snipe-j
        "T" 'evil-snipe-J)))
      keymap)))

(defvar evil-qgmlwy-keymap
  (evil-qgmlwy--make-keymap)
  "Keymap for evil-qgmlwy-mode.")

(defun evil-qgmlwy--refresh-keymap ()
  "Refresh the keymap using the current configuration."
  (setq evil-qgmlwy-keymap (evil-qgmlwy--make-keymap)))

;;;###autoload
(define-minor-mode evil-qgmlwy-mode
  "Minor mode with evil-mode enhancements for the QGMLWY keyboard layout."
  :keymap evil-qgmlwy-keymap
  :lighter " hnei")

;;;###autoload
(define-globalized-minor-mode global-evil-qgmlwy-mode
  evil-qgmlwy-mode
  (lambda () (evil-qgmlwy-mode t))
  "Global minor mode with evil-mode enhancements for the QGMLWY keyboard layout.")

(provide 'evil-qgmlwy)

;;; evil-qgmlwy.el ends here

