;; Time-stamp: <2015-02-23 15:19:04 kmodi>

;; Projectile
;; Source: https://github.com/bbatsov/projectile

(use-package projectile
  :init
  (progn
    (setq projectile-ag-command (concat "\\ag " ; used unaliased version of `ag': \ag
                                        "-i " ; case insensitive
                                        "-f " ; follow symbolic links
                                        "--skip-vcs-ignores "
                                        ; Ignore files/dirs ONLY from `.agignore',
                                        ; NOT from vcs ignore files like .gitignore
                                        "-g ''" ; get file names matching the regex '',
                                        ; that is, ALL files not in ignore lists
                                        " | tr '\\n' '\\0'"
                                        ; Projectile needs null-character separated
                                        ; string (\0); ag returns newline (\n)
                                        ; separated list; So pipe the `ag' output
                                        ; to `tr' and replace all \n with \0.
                                        )))
  :config
  (progn

    (defun projectile-get-ext-command ()
      "Override the projectile-defined function so that `ag' is always used for
getting a list of all files in a project."
      projectile-ag-command)

    ;; Make the file list creation faster by NOT calling `projectile-get-sub-projects-files'
    (defun projectile-get-repo-files ()
      (projectile-files-via-ext-command (projectile-get-ext-command)))

    (add-to-list 'projectile-ignored-projects `,(concat (getenv "HOME") "/")) ; Don't consider my home dir as a project

    (defun projectile-cache-files-find-file-hook ()
      "Function for caching files with `find-file-hook'."
      (when (and projectile-enable-caching
                 (projectile-project-p)
                 (not (member (projectile-project-p) projectile-ignored-projects)))
        (projectile-cache-current-file)))

    ;; (setq projectile-enable-caching nil)
    (setq projectile-enable-caching t) ; Enable caching, otherwise
                                        ; `projectile-find-file' is really slow
                                        ; for large projects
    (dolist (item '(".SOS" "nobackup"))
      (add-to-list 'projectile-globally-ignored-directories item))
    (dolist (item '("GTAGS" "GRTAGS" "GPATH"))
      (add-to-list 'projectile-globally-ignored-files item))
    ;; Customize the Projectile mode-line lighter
    ;; (setq projectile-mode-line '(:eval (format " Projectile[%s]" (projectile-project-name))))
    (setq projectile-mode-line " Prj")

    (defun projectile-project-name ()
      "Return project name."
      (let ((project-root
             (condition-case nil
                 (projectile-project-root)
               (error default-directory)))
            project-name)
        (setq project-name (file-name-nondirectory
                            (directory-file-name project-root)))
        (while (string-match "\\(sos_\\|\\bsrc\\b\\)" project-name)
          (setq project-root (replace-regexp-in-string
                              "\\(.*\\)/.+/*$" "\\1" project-root))
          (setq project-name (file-name-nondirectory
                              (directory-file-name project-root))))
        project-name))

    (defhydra hydra-projectile-other-window (:color teal)
      "projectile-other-window"
      ("f"  projectile-find-file-other-window        "file")
      ("g"  projectile-find-file-dwim-other-window   "file dwim")
      ("d"  projectile-find-dir-other-window         "dir")
      ("b"  projectile-switch-to-buffer-other-window "buffer")
      ("q"  nil                                      "cancel" :color blue))

    (defhydra hydra-projectile (:color teal)
      "
     PROJECTILE

     Find File            Search/Tags          Buffers                Cache
------------------------------------------------------------------------------------------
_s-f_: file            _a_: ag              _i_: Ibuffer           _c_: cache clear
_ff_: file dwim       _g_: update gtags    _b_: switch to buffer  _x_: remove known project
_fd_: file curr dir   _o_: multi-occur     _s-k_: Kill all buffers  _X_: cleanup non-existing
_r_: recent file                                                 _z_: cache current
_d_: dir

"
      ("a"   projectile-ag                      nil)
      ("b"   projectile-switch-to-buffer        nil)
      ("c"   projectile-invalidate-cache        nil)
      ("d"   projectile-find-dir                nil)
      ("s-f" projectile-find-file               nil)
      ("ff"  projectile-find-file-dwim          nil)
      ("fd"  projectile-find-file-in-directory  nil)
      ("g"   ggtags-update-tags                 nil)
      ("s-g" ggtags-update-tags                 nil)
      ("i"   projectile-ibuffer                 nil)
      ("K"   projectile-kill-buffers            nil)
      ("s-k" projectile-kill-buffers            nil)
      ("m"   projectile-multi-occur             nil)
      ("o"   projectile-multi-occur             nil)
      ("s-p" projectile-switch-project          "switch project")
      ("p"   projectile-switch-project          nil)
      ("s"   projectile-switch-project          nil)
      ("r"   projectile-recentf                 nil)
      ("x"   projectile-remove-known-project    nil)
      ("X"   projectile-cleanup-known-projects  nil)
      ("z"   projectile-cache-current-file      nil)
      ("`"   hydra-projectile-other-window/body "other window")
      ("q"   nil                                "cancel" :color blue))

    (bind-key "s-f" #'hydra-projectile/body  modi-mode-map)
    (bind-key "s-p" #'hydra-projectile/body  modi-mode-map)

    (projectile-global-mode)))


(provide 'setup-projectile)

;; Do "touch ${PRJ_HOME}/.projectile" when updating a project. If the time stamp of
;; the ".projectile" is newer than that of the project cache then the existing
;; cache will be invalidated and recreated.
