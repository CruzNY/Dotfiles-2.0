(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (grandshell)))
 '(custom-safe-themes
   (quote
    ("04589c18c2087cd6f12c01807eed0bdaa63983787025c209b89c779c61c3a4c4" "3860a842e0bf585df9e5785e06d600a86e8b605e5cc0b74320dfe667bcbe816c" default)))
 '(fringe-mode 6 nil (fringe))
 '(global-display-line-numbers-mode t)
 '(linum-format (quote dynamic))
 '(package-selected-packages
   (quote
    (magit telephone-line cherry-blossom-theme emmet-mode ranger highlight-parentheses smartparens dashboard centaur-tabs meghanada org-bullets company-jedi jdee jedi-core yasnippet flycheck neotree all-the-icons auto-complete markdown-mode anaconda-mode elpy flycheck-pycheckers format-all jedi vbasense ejson-mode grandshell-theme)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))
;;(require 'buffer-flip)
;;(global-set-key (kbd "C-x p") 'buffer-flip-forward)

;; Adding Line Numbers
(global-display-line-numbers-mode)

;; Org Mode
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Neo Tree Icons
(require 'all-the-icons)
(setq neo-theme (if (display-graphic-p) 'icons 'arrows))

;; centaur-tabs configuration
(require 'centaur-tabs)
(setq centaur-tabs-style "bar")
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-set-bar 'over)
(setq centaur-tabs-set-modified-marker t)
(setq
 centaur-tabs-style "bar"
 centaur-tabs-set-icons t
 centaur-tabs-set-bar 'under
 centaur-tabs-set-modified-marker t
 centaur-tabs-modified-marker "*"
 x-underline-at-descent-line t
 )
(centaur-tabs-mode t)
(centaur-tabs-headline-match)
(global-set-key (kbd "C-x p") 'centaur-tabs-forward)
(global-set-key (kbd "C-c p")  'centaur-tabs-backward)

;; Dashboard Settings
(require 'dashboard)
(dashboard-setup-startup-hook)

;; Telephone Line / Mode Line
(require 'telephone-line)
(telephone-line-mode 1)
(setq telephone-line-lhs
      '((evil   . (telephone-line-evil-tag-segment))
        (accent . (telephone-line-vc-segment
                   telephone-line-erc-modified-channels-segment
                   telephone-line-process-segment))
        (nil    . (telephone-line-minor-mode-segment
                   telephone-line-buffer-segment))))
(setq telephone-line-rhs
      '((nil    . (telephone-line-misc-info-segment))
        (accent . (telephone-line-major-mode-segment))
        (evil   . (telephone-line-airline-position-segment))))

;; Hideshow Settings 
(load-library "hideshow")
(global-set-key (kbd "C-+") 'hs-show-block)
(global-set-key (kbd "C-x C-\\") 'hs-hide-block)
(add-hook 'java-mode-common-hook   'hs-minor-mode)

;; SmartParen Settings
(require 'smartparens-config)
(add-hook 'java-mode-hook #'smartparens-mode)
(add-hook 'python-mode-hook #'smartparens-mode)

;; Hightlight Paren
(require 'highlight-parentheses)

;; Automatically starting these modes when filetype is opened. 
(add-hook 'java-mode-hook 'highlight-parentheses-mode)
(add-hook 'python-mode-hook 'highlight-parentheses-mode)
(add-hook 'python-mode-hook 'elpy-mode)
(add-hook 'python-mode-hook 'anaconda-mode)

;; Python Stuff
(add-to-list 'auto-mode-alist '("\\.py\\'" . elpy-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . anaconda-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

;; Java Stuff
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))
