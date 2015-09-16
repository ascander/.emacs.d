;; Do NOT manually edit the below custom-set-variables block
;; Comments added manually in above custom-set-variables block are not
;; retained. To add comments, do `M-x customize` search for that variable, click
;; on State button for that variable and click on "Add comment". After doing
;; that, click on State button once again and click on "Save for future sessions".
;; *Manually added comments get deleted when emacs updates this block.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-stop-words (quote ("/" "//" "/*" "//*" "///" "////")))
 '(after-save-hook
   (quote
    (executable-make-buffer-file-executable-if-script-p)))
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(auto-compression-mode t nil (jka-compr) "uncompress->edit->save->compress .gz, .bz2, .Z files on the fly")
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(default-input-method "rfc1345")
 '(delete-selection-mode t nil nil "typing anything after highlighting text overwrites that text; source: http://emacsredux.com/blog/2013/04/12/delete-selection-on-insert/")
 '(fci-rule-color "#585858")
 '(fringe-mode nil nil (fringe))
 '(indent-tabs-mode nil nil nil "use spaces instead of tabs for indentation")
 '(indicate-buffer-boundaries (quote ((top . right) (bottom . right))) nil nil "show frame boundaries in the fringe; as the fringe is activated only for the right-hand side, the buffer boundaries (top, bottom) are marked on the right side")
 '(keyboard-coding-system (quote utf-8-unix) nil nil "default EOL system = that of Unix")
 '(next-line-add-newlines nil nil nil "Do not auto-add newlines at the end of the file on pressing `C-n` or down arrow")
 '(org-confirm-elisp-link-not-regexp "\\(.*switch\\-to\\-buffer.*\\|org-show\\)")
 '(outline-minor-mode-prefix "\243")
 '(require-final-newline nil nil nil "Do not auto-add a final newline (if one is not present) when saving/visiting a file")
 '(safe-local-variable-values
   (quote
    ((eval add-hook
           (quote before-save-hook)
           (function modi/outline-toc)
           nil :local)
     (eval define-key temp-mode-map
           (kbd "<C-f10>")
           (function dv-docs-dis))
     (eval define-key temp-mode-map
           (kbd "<S-f10>")
           (function dv-docs-ci))
     (eval define-key temp-mode-map
           (kbd "<s-f10>")
           (function modi/org-export-to-html-txt-pdf))
     (eval define-key temp-mode-map
           (kbd "<f10>")
           (function dv-docs-co))
     (do-not-delete-trailing-whitespace . t)
     (checkdoc-minor-mode . t)
     (eval when
           (featurep
            (quote aggressive-indent))
           (aggressive-indent-mode -1))
     (eval when
           (fboundp
            (quote rainbow-mode))
           (rainbow-mode 1))
     (org-export-allow-bind-keywords . t)
     (org-confirm-babel-evaluate)
     (lisp-backquote-indentation . t)
     (eval when
           (require
            (quote rainbow-mode)
            nil t)
           (rainbow-mode 1))
     (py-indent-offset . 4)
     (header-auto-update-enabled)
     (lisp-indent-function . lisp-indent-function))))
 '(send-mail-function (quote sendmail-send-it))
 '(show-paren-mode t nil (paren) "allow one to see matching pairs of parentheses; when point is on one of the paired characters, the other is highlighted")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(visible-bell t nil nil "enable the visible bell or screen blink to happen when there's any error"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
