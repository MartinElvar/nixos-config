;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Martin Elvar"
      user-mail-address "m@martinelvar.dk")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq
 ;;doom-font (font-spec :family "Fira Mono" :size 12)
 projectile-project-search-path '("~/Projects/" "~/Projects/elixir")
 web-mode-markup-indent-offset 2
 web-mode-code-indent-offset 2
 web-mode-css-indent-offset 2
 js-indent-level 2
 json-reformat:indent-width 2
)

;; Enable folding
(setq lsp-enable-folding t)

;; Add origami and LSP integration
;; (use-package! lsp-origami)
;; (add-hook! 'lsp-after-open-hook #'lsp-origami-try-enable)


;; Focus treemacs buffer
(map! :leader
      :desc "Jump to treemacs window"
      "o o" #'treemacs-select-window)

;; Expand select
(map! :desc "Expand select"
      "∑" #'er/expand-region)

;; Comment line
(map! :leader
      :desc "Toggle comment line"
      "e e" #'evilnc-comment-or-uncomment-lines)

(setq lsp-file-watch-threshold 5000)

;; (with-eval-after-load 'lsp-mode
;;   (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.my-folder\\'"))

;; Assumes web-mode and elixir-mode are already set up
;; (use-package! polymode
;;   :mode ("\\.ex\\'" . poly-elixir-web-mode)
;;   :init (setq! web-mode-engines-alist '(("elixir" . "\\.ex\\'")))
;;   :hook (elixir-mode . poly-elixir-web-mode)
;;   :config
;;   (define-hostmode poly-elixir-hostmode :mode 'elixir-mode)
;;   (define-innermode poly-liveview-expr-elixir-innermode
;;     :mode 'web-mode
;;     :head-matcher (rx line-start (* space) "~H" (= 3 (char "\"'")) line-end)
;;     :tail-matcher (rx line-start (* space) (= 3 (char "\"'")) line-end)
;;     :head-mode 'host
;;     :tail-mode 'host
;;     :allow-nested nil
;;     :keep-in-mode 'host
;;     :fallback-mode 'host)
;;   (define-polymode poly-elixir-web-mode
;;     :hostmode 'poly-elixir-hostmode
;;     :innermodes '(poly-liveview-expr-elixir-innermode)))

;; Bullet UTF-8 icons for org documents
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Change specific characters to unicode symbols
(defun my/org-mode/load-prettify-symbols ()
  (interactive)
  (setq prettify-symbols-alist
  	(mapcan (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
    		'(("lambda" . ?λ)
		 ("|>" . ?▷)
		 ("<|" . ?◁)
		 ("->>" . ?↠)
		 ("->" . ?→)
		 ("<-" . ?←)
		 ("=>" . ?⇒)
		 ("<=" . ?≤)
		 (">=" . ?≥))))
	(prettify-symbols-mode 1))
(add-hook 'org-mode-hook 'my/org-mode/load-prettify-symbols)


;; Set height of bullets
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.20))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.15))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.12))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.08))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.05))))
)
