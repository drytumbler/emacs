(deftheme dark-night
  "Created 2024-07-10.")

;;; color definitions
(setq dark-night-theme-colors '(
  ("#dddddd" . "Light Grey")
  ("#aaaaaa" . "Soft Grey")
  ("#aaaa88" . "Arabic Khaki")
  ("#ddddbb" . "Egg Green")
  ("#eedd82" . "Dulce Vanilla")
  ("#d3c011" . "Mango Yellow")
  ("#d3a011" . "Clementine Orange")
  ("#ffa07a" . "Light Salmon") 
  ("#ee4444" . "Dim Persian")
  ("#dd3227" . "Freakish Red")
  ("#16fbde" . "Mint Aquarius")
  ("#34dddd" . "Holy Cyan")
  ("#16bbde" . "Soft Sky")
  ("#06aacc" . "Apple Blue")
  ("#addd37" . "Pleasant Lime")
  ("#37dd37" . "Approval Green")
  ("#434112" . "Wild Khaki")
  ("#272602" . "Flanders Fields")
  ("#262702" . "Cripple Creek")
  ("#151505" . "Dark Mud")
  ("#222222" . "Antracite")))



(custom-theme-set-faces
 'dark-night
 '(cursor ((t (:background "#d3c011"))))
 
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#222222" :foreground "#ddddbb" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 108 :width normal :foundry "ADBO" :family "Source Code Pro"))))
 
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((((type w32)) (:foundry "outline" :family "Arial")) (t (:family "American Typerwriter"))))

 '(escape-glyph ((t (:foreground "#aaaa88"))))
 '(homoglyph ((t (:inherit default))))
 
 '(minibuffer-prompt ((t (:weight bold :height 1.1))))

 '(highlight ((t (:background "#434112" :foreground "#dddddd"))))
 '(region ((t (:extend t :background "#eedd82" :foreground "#222222"))))
 '(secondary-selection ((t (:extend t :background "#d3a011" :foreground "#222222"))))

 '(shadow ((t (:foreground "#AAAAAA"))))
 '(trailing-whitespace ((t (:background "#34DDDD" :foreground "#222222"))))

 ;; font-lock-faces
 '(font-lock-bracket-face ((t (:inherit font-lock-punctuation-face))))
 '(font-lock-builtin-face ((t (:inherit font-lock-constant-face))))
 '(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face))))
 '(font-lock-comment-face ((t (:foreground "#aaaa88" :slant oblique))))
 '(font-lock-constant-face ((t (:foreground "#addd37"))))
 '(font-lock-delimiter-face ((t (:inherit font-lock-punctuation-face))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face))))
 '(font-lock-doc-markup-face ((t (:inherit font-lock-constant-face))))
 '(font-lock-escape-face ((t (:inherit font-lock-regexp-grouping-backslash))))
 '(font-lock-function-call-face ((t (:foreground "#eedd82"))))
 '(font-lock-function-name-face ((t (:foreground "#eedd82"))))
 '(font-lock-keyword-face ((t (:foreground "#ee4444"))))
 '(font-lock-negation-char-face ((t (:inherit font-lock-keyword-face :inherit bold))))
 '(font-lock-number-face ((t nil)))
 '(font-lock-misc-punctuation-face ((t (:inherit font-lock-punctuation-face))))
 '(font-lock-operator-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face))))
 '(font-lock-property-name-face ((t (:inherit font-lock-variable-name-face))))
 '(font-lock-property-use-face ((t (:inherit font-lock-property-name-face))))
 '(font-lock-punctuation-face ((t (:foreground "#d3a011"))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit escape-glyph))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "light salmon"))))
 '(font-lock-type-face ((t (:foreground "#d3c011"))))
 '(font-lock-variable-name-face ((((class grayscale) (background light)) (:slant italic :weight bold :foreground "Gray90")) (((class grayscale) (background dark)) (:slant italic :weight bold :foreground "DimGray")) (((class color) (min-colors 88) (background light)) (:foreground "sienna")) (((class color) (min-colors 88) (background dark)) (:foreground "#eedd82")) (((class color) (min-colors 16) (background light)) (:foreground "#d3a011")) (((class color) (min-colors 16) (background dark)) (:foreground "#eedd82")) (((class color) (min-colors 8)) (:weight light :foreground "yellow")) (t (:slant italic :weight bold))))
 '(font-lock-variable-use-face ((t (:inherit font-lock-variable-name-face))))
 '(font-lock-warning-face ((t (:inherit error))))
 
 '(button ((t (:inherit link))))
 '(link ((t (:foreground "#d3c011"))))
 '(link-visited ((t (:inherit link :foreground "#d3a011"))))

 '(fringe ((t (:background "#222222"))))
 '(header-line ((t (:inherit mode-line :background "grey20" :foreground "grey90" :box nil))))
 '(tooltip ((((class color)) (:inherit (variable-pitch) :foreground "black" :background "ddddbb")) (t (:inherit (variable-pitch)))))
 '(mode-line ((((class color) (min-colors 88)) (:foreground "black" :background "grey75" :box (:line-width (1 . -1) :color nil :style released-button))) (t (:inverse-video t))))
 '(mode-line-buffer-id ((t (:weight bold))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((supports :box t) (class color) (min-colors 88)) (:box (:line-width (2 . 2) :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((default (:inherit (mode-line))) (((class color) (min-colors 88) (background light)) (:background "grey90" :foreground "grey20" :box (:line-width (1 . -1) :color "grey75" :style nil) :weight light)) (((class color) (min-colors 88) (background dark)) (:background "grey30" :foreground "grey80" :box (:line-width (1 . -1) :color "grey40" :style nil) :weight light))))

 '(isearch ((t (:background "#37dd77" :foreground "#222222"))))
 '(isearch-fail ((t (:inherit error))))
 '(lazy-highlight ((t (:background "#eedd82" :distant-foreground "#222222"))))
 '(match ((((class color) (min-colors 88) (background light)) (:background "khaki1")) (((class color) (min-colors 88) (background dark)) (:background "RoyalBlue3")) (((class color) (min-colors 8) (background light)) (:foreground "black" :background "yellow")) (((class color) (min-colors 8) (background dark)) (:foreground "white" :background "blue")) (((type tty) (class mono)) (:inverse-video t)) (t (:background "gray"))))
 '(query-replace ((t (:inherit (isearch)))))

 '(error ((t (:inherit bold :foreground "#dd3227"))))
 '(next-error ((t (:inherit (region)))))

 '(org-block-begin-line ((t (:background "#151505" :extend t :inherit shadow))))
 '(org-block-end-line ((t (:background "#151505" :extend t :inherit shadow))))
 '(org-block ((t (:background "#151505" :extend t :inherit shadow))))
 '(org-todo ((t (:inverse-video t :inherit bold))))
 '(org-done ((t (:inherit bold :inherit font-lock-comment-face)))))

(provide-theme 'dark-night)
