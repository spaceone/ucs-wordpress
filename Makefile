#!/bin/make -f

FQDN := $(shell ucr get hostname).$(shell ucr get domainname)

.PHONY: build
build:
	docker build -t ucswordpress:test .

.PHONY: run
run:
	docker run -d \
		--name ucswordpress \
		--restart unless-stopped \
		-e "CA_CERT_URL=http://$(FQDN)/ucs-root-ca.crt" \
		--env-file "$(CURDIR)/apps/wordpress/wordpress.env" \
		-p 39004:80 \
		--volume "$(CURDIR)/apps/wordpress/wordpress:/var/www/html" \
		ucswordpress:test

.PHONY: install
install:
	cp wordpress.conf /etc/apache2/ucs-sites.conf.d/wordpress.conf
	systemctl reload apache2.service
	cp 60ucs-wordpress.inst /usr/lib/univention-install/
	univention-run-join-scripts --run-scripts 60ucs-wordpress.inst
