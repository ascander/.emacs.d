;; Time-stamp: <2014-10-30 11:28:13 kmodi>

;; Multiple Cursors
;; Source: https://github.com/magnars/multiple-cursors.el

(req-package multiple-cursors
  ;; :commands (mc/edit-lines
  ;;            mc/add-cursor-on-click
  ;;            mc/mark-all-like-this
  ;;            mc/mark-previous-like-this
  ;;            mc/mark-next-like-this
  ;;            mc/mark-more-like-this-extended
  ;;            mc/mark-all-like-this-dwim
  ;;            set-rectangular-region-anchor)
  :require (region-bindings-mode)
  :init
  (progn
    (defun toggle-mc-hide-unmatched-lines-mode ()
      (interactive)
      (if mc-hide-unmatched-lines-mode
          (hum/keyboard-quit)
        (mc-hide-unmatched-lines-mode t)))

    (bind-keys
     :map modi-mode-map
     ("C-S-c C-S-c"   . mc/edit-lines)
     ("C->"           . mc/mark-next-like-this)
     ("C-<"           . mc/mark-previous-like-this)
     ("C-c C-<"       . mc/mark-all-like-this)
     ("C-S-<mouse-1>" . mc/add-cursor-on-click))

    (bind-keys
     :map region-bindings-mode-map
     ("a" . mc/mark-all-like-this)
     ("p" . mc/mark-previous-like-this)
     ("n" . mc/mark-next-like-this)
     ("P" . mc/cycle-backward)
     ("N" . mc/cycle-forward)
     ("m" . mc/mark-more-like-this-extended)
     ("h" . toggle-mc-hide-unmatched-lines-mode))

    (bind-to-modi-map "m" mc/mark-all-like-this-dwim)
    (bind-to-modi-map "r" set-rectangular-region-anchor)))


(provide 'setup-multiple-cursors)


;; ## Command overview

;; ### Mark one more occurrence

;;  - `mc/mark-next-like-this`: Adds a cursor and region at the next part of the buffer forwards that matches the current region.
;;  - `mc/mark-next-word-like-this`: Like `mc/mark-next-like-this` but only for whole words.
;;  - `mc/mark-next-symbol-like-this`: Like `mc/mark-next-like-this` but only for whole symbols.
;;  - `mc/mark-previous-like-this`: Adds a cursor and region at the next part of the buffer backwards that matches the current region.
;;  - `mc/mark-previous-word-like-this`: Like `mc/mark-previous-like-this` but only for whole words.
;;  - `mc/mark-previous-symbol-like-this`: Like `mc/mark-previous-like-this` but only for whole symbols.
;;  - `mc/mark-more-like-this-extended`: Use arrow keys to quickly mark/skip next/previous occurances.
;;  - `mc/add-cursor-on-click`: Bind to a mouse event to add cursors by clicking. See tips-section.

;; ### Mark many occurrences

;;  - `mc/mark-all-like-this`: Marks all parts of the buffer that matches the current region.
;;  - `mc/mark-all-words-like-this`: Like `mc/mark-all-like-this` but only for whole words.
;;  - `mc/mark-all-symbols-like-this`: Like `mc/mark-all-like-this` but only for whole symbols.
;;  - `mc/mark-all-in-region`: Prompts for a string to match in the region, adding cursors to all of them.
;;  - `mc/mark-all-like-this-in-defun`: Marks all parts of the current defun that matches the current region.
;;  - `mc/mark-all-words-like-this-in-defun`: Like `mc/mark-all-like-this-in-defun` but only for whole words.
;;  - `mc/mark-all-symbols-like-this-in-defun`: Like `mc/mark-all-like-this-in-defun` but only for whole symbols.
;;  - `mc/mark-all-like-this-dwim`: Tries to be smart about marking everything you want. Can be pressed multiple times.

;; ### Special

;;  - `set-rectangular-region-anchor`: Think of this one as `set-mark` except you're marking a rectangular region.
;;  - `mc/mark-sgml-tag-pair`: Mark the current opening and closing tag.
;;  - `mc/insert-numbers`: Insert increasing numbers for each cursor, top to bottom.
;;  - `mc/sort-regions`: Sort the marked regions alphabetically.
;;  - `mc/reverse-regions`: Reverse the order of the marked regions.

;; ## Tips and tricks

;; - To get out of multiple-cursors-mode, press `<return>` or `C-g`. The latter will
;;   first disable multiple regions before disabling multiple cursors. If you want to
;;   insert a newline in multiple-cursors-mode, use `C-j`.
;;
;; - Sometimes you end up with cursors outside of your view. You can
;;   scroll the screen to center on each cursor with `C-v` and `M-v`.
;;
;; - Try pressing `mc/mark-next-like-this` with no region selected. It will just add a cursor
;;   on the next line.
;;
;; - Try pressing `mc/mark-all-like-this-dwim` on a tagname in html-mode.
;;
;; - Notice that the number of cursors active can be seen in the modeline.
;;
;; - If you get out of multiple-cursors-mode and yank - it will yank only
;;   from the kill-ring of main cursor. To yank from the kill-rings of
;;   every cursor use yank-rectangle, normally found at C-x r y.
;;
;; - You can use `mc/reverse-regions` with nothing selected and just one cursor.
;;   It will then flip the sexp at point and the one below it.
;;
;; - If you would like to keep the global bindings clean, and get custom keybindings
;;   when the region is active, you can try [region-bindings-mode](https://github.com/fgallina/region-bindings-mode).
;;
;; BTW, I highly recommend adding `mc/mark-next-like-this` to a key binding that's
;; right next to the key for `er/expand-region`.
