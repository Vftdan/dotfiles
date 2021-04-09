;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Tlwg Mono" :size 26))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(setq evil-split-window-below t)
(setq evil-vsplit-window-right t)
(setq indent-tabs-mode t)
(setq highlight-indent-guides-character 9482)
(add-hook '+popup-mode-hook (cmd! (if +popup-mode (progn
    (remove-hook 'doom-escape-hook #'+popup-close-on-escape-h)
    (map! :map evil-window-map "C-z" (cmd! (+popup-close-on-escape-h)))
))) 'append)
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

(defun split-and-lookup-definition (identifier &optional arg)
    (interactive (list (doom-thing-at-point-or-region) current-prefix-arg))
    (progn (evil-window-split) (+lookup/definition identifier arg))
)

(defun search-replace-selected (beg end)
    (interactive "r")
    (evil-visualstar/begin-search beg end t)
    (evil-ex (concat "%s/\\V" (replace-regexp-in-string "[/\\\\]" "\\\\\\&" (evil-get-register ?/)) "//g"))
)

(defun duplicate-selected (count beg end &optional type)
    (interactive "p\nr")
    (if (eq count 0) (setq count 1))
    (let ((byteidx (point)))
        (cond
            ((and (fboundp 'cua--global-mark-active)
                (fboundp 'cua-copy-region-to-global-mark)
                (cua--global-mark-active))
                (cua-copy-region-to-global-mark beg end))
            ((eq type 'block)
                (evil-yank-rectangle beg end ?\"
                    ;;"
                ))
            ((or (memq type '(line screen-line)) (eq type nil))
                (progn
                    (goto-char beg)
                    (beginning-of-line)
                    (setq beg (point))
                    (goto-char (- end 1))
                    (end-of-line)
                    (setq end (point))
                    (evil-yank-lines beg end ?\"
                        ;;"
                    )
                    (setq end (+ end 1))
                )
            )
            (t
                (evil-yank-characters beg end ?\"
                    ;;"
                ))
        )
        (goto-char (- end 1))
        (evil-paste-after count ?\"
            ;;"
        )
        (goto-char byteidx)
    )
)

(evil-define-command duplicate-selected-visual (count beg end &optional type)
    (interactive "p<R>")
    (if (eq count 0) (setq count 1))
    (evil-exit-visual-state)
    (duplicate-selected count beg end type)
)

(evil-define-command duplicate-selected-normal (count)
    (interactive "p")
    (if (eq count 0) (setq count 1))
    (duplicate-selected count (point) (+ (point) 1) nil)
)

(map! :map evil-window-map
    "C-t"               #'+workspace:new
    "z"                 #'doom/window-enlargen
    "<C-tab>"           #'+workspace:switch-next
    "<C-S-tab>"         #'+workspace:switch-previous
    "<C-S-iso-lefttab>" #'+workspace:switch-previous
    "%"                 #'evil-window-vsplit
    "\""                #'evil-window-split
    (:prefix "g"
        "d"             #'split-and-lookup-definition
        "t"             #'+workspace:switch-next
        "T"             #'+workspace:switch-previous
    )
)

(map!
    :n "<C-tab>"           #'+workspace:switch-next
    :n "<C-S-tab>"         #'+workspace:switch-previous
    :n "<C-S-iso-lefttab>" #'+workspace:switch-previous
    :n "C-/"               #'comment-dwim
    :n "C-_"               #'comment-dwim
    :n "M-R"               #'+eval/buffer
    :n "M-r"               #'query-replace-regexp
    :n "C-S-d"             #'evil-scroll-down
    :n "C-d"               #'duplicate-selected-normal
)

(map!
    :v "C-/"               #'comment-dwim
    :v "C-_"               #'comment-dwim
    :v "M-r"               #'search-replace-selected
    :v "C-S-d"             #'evil-scroll-down
    :v "C-d"               #'duplicate-selected-visual
)

(map!
    :i "<C-tab>"           #'+workspace:switch-next
    :i "<C-S-tab>"         #'+workspace:switch-previous
    :i "<C-S-iso-lefttab>" #'+workspace:switch-previous
    :i "<backtab>"         #'evil-shift-left-line
    :i "C-d"               #'duplicate-selected-normal
    :i "DEL"               #'backward-delete-char
    :i "C-h"               #'backward-delete-char
    :i "TAB"               (cmd! (insert-tab 1))
    :i "C-6"               #'toggle-input-method
    :i "C-^"               #'toggle-input-method
)

(map! :map ein:notebook-mode-map
    :n "<C-return>"        #'ein:worksheet-execute-cell
    :i "<C-return>"        #'ein:worksheet-execute-cell
    :n "<S-return>"        #'ein:worksheet-execute-cell-and-goto-next
    :i "<S-return>"        #'ein:worksheet-execute-cell-and-goto-next
    (:prefix "M-c"
        "d"                #'ein:worksheet-kill-cell
        "y"                #'ein:worksheet-copy-cell
        "p"                #'ein:worksheet-yank-cell
        "t"                #'ein:worksheet-change-cell-type
        "a"                #'ein:worksheet-insert-cell-above
        "b"                #'ein:worksheet-insert-cell-below
        "k"                #'ein:worksheet-goto-prev-input
        "j"                #'ein:worksheet-goto-next-input
        (:prefix "e"
             "a"           #'ein:worksheet-execute-all-cells-above
             "b"           #'ein:worksheet-execute-all-cells-below
        )
    )
)

(map! :after evil-org :map evil-org-mode-map
    :i "<backtab>"         #'org-metaleft
    :i "C-d"               #'duplicate-selected-normal
    :i "C-h"               #'backward-delete-char
)
