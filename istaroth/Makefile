.PHONY: all build sync clean
all: build

build:
	emacs -Q --script build-site.el

sync:
	tar cf istaroth.org.tar public/*
	gzip istaroth.org.tar
	scp istaroth.org.tar.gz "admin@istaroth.org:/home/admin"
	rm istaroth.org.tar.gz
	ssh admin@istaroth.org "cd /usr/share/nginx; rm -rf istaroth.org; tar xf /home/admin/istaroth.org.tar.gz; mv public istaroth.org"

clean:
	rm -rf public/
	find content -type d -name ltximg -exec rm -rf {} +
