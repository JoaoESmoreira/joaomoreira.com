
(require 'ox-publish)

(defun my/org-html-src-block (src-block _contents info)
  (let* ((lang (org-element-property :language src-block))
         (code (org-export-format-code-default src-block info))
         ;; mapeamentos simples de Org → highlight.js
         (hljs (pcase (downcase (or lang ""))
                 ("emacs-lisp" "lisp")
                 ("elisp" "lisp")
                 ("shell" "bash")
                 ("sh" "bash")
                 ("bash" "bash")
                 ("python" "python")
                 (_ (downcase lang)))))
    (format "<pre><code class=\"language-%s\">%s</code></pre>" (or hljs "") code)))

(with-eval-after-load 'ox-html
  (advice-add 'org-html-src-block :override #'my/org-html-src-block))

(setq org-html-htmlize-output-type nil)



;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "my-org-site"
             :recursive t
             :base-directory "./content"
	     :base-extension "org"
             :publishing-directory "./docs"
             :publishing-function 'org-html-publish-to-html
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc t                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)))    ;; Don't include time stamp in file

(setq org-html-validation-link nil)
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")



;; Generate the site output
(org-publish-all t)

(message "Build complete")
