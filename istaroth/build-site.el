;; run as: emacs -Q --script build-site.el

(require 'package)

(setq package-user-dir (expand-file-name "./packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(package-install 'htmlize)

(require 'ox-publish)

(setq org-html-validation-link nil)
(setq org-html-with-latex 'dvisvgm) ;; might use imagemagick
(setq org-html-head (with-temp-buffer
		      (insert-file-contents "style.css")
		      (buffer-string)))

(defun publish-probe (plist filename pub-dir)
  (print filename)
  (org-html-publish-to-html plist filename pub-dir))

(defun attachment-probe (plist filename pub-dir)
  (print filename)
  (org-publish-attachment plist filename pub-dir))

(add-to-list 'org-src-lang-modes '("sage" . python))

(setq org-publish-project-alist
      '(("istaroth.org-org"
	 :recursive t
	 :base-directory "./content"
	 :publishing-directory "./public"
	 :publishing-function publish-probe
	 :exclude "\\.conf\\.org"
	 :author "calx"
	 :with-author t
	 :with-creator t
	 :with-toc nil
	 :section-numbers nil
	 :time-stamp-file t)
	("istaroth.org-static"
	 :recursive t
	 :base-directory "./content"
	 :publishing-directory "./public"
	 :publishing-function attachment-probe
	 :base-extension "css\\|js\\|png\\|jpg\\|svg\\|html\\|txt")
	("istaroth.org"
	 :components ("istaroth.org-org" "istaroth.org-static"))))

(org-publish-project "istaroth.org" t)

(message "Build complete!")
