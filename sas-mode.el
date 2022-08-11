(defconst sas-mode-syntax-table
  (with-syntax-table (copy-syntax-table)
    ;; C/C++ style comments?
    (modify-syntax-entry ?/ ". 124b")
    (modify-syntax-entry ?* ". 23")
    (modify-syntax-entry ?\n "> b")

    ;; Chars are the same as strings
    (modify-syntax-entry ?' "\"")
    (syntax-table))
  "Syntax Table for 'sas-mode'.")

(eval-and-compile
  (defconst sas-keywords
    '("function" "action" "end" "do" "if" "then" "else" "in" "over")))

(defconst sas-highlights
  `((,(regexp-opt sas-keywords 'symbols) . font-lock-keyword-face)))

;;;#autoload
(define-derived-mode sas-mode prog-mode "sas"
  "Major Mode for editing SAS code."

  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 4)
  (setq-local indent-line-function 'insert-tab)
  (setq-local backward-delete-char-untabify-method 'hungry)
  (setq-local evil-shift-width 4)
  (setq-local comment-start "/*")
  (setq-local comment-end "*/")

  (company-mode)
  (setq-local company-dabbrev-downcase nil)

  (setq-local electric-indent-inhibit t)
  (add-hook 'before-save-hook
            (lambda ()
              (when (eq major-mode 'sas-mode) (untabify (point-min) (point-max)))))

  :syntax-table sas-mode-syntax-table
  (setq font-lock-defaults '(sas-highlights)))

;;;#autoload
(add-to-list 'auto-mode-alist '("\\.sas\\'" . sas-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . sas-mode))

(provide 'sas-mode)
