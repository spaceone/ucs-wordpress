FROM wordpress:6.7.2-php8.3-apache
RUN set -ex; apt-get update \
  && apt-get install -y \
    libmcrypt-dev \
    libldap2-dev \
    ldap-utils \
    wget \
    ssl-cert \
    unzip \
    libzip-dev \
  && pecl install mcrypt-1.0.7 \
  && docker-php-ext-enable mcrypt \
  && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
  && docker-php-ext-install -j$(nproc) ldap zip \
  && rm -rf /var/lib/apt/lists/* \
  && a2enmod ssl \
  && a2ensite default-ssl \
  && wget https://downloads.wordpress.org/plugin/authldap.zip -O /root/authldap.zip

RUN set -ex; \
  mkdir -p /etc/ldap && \
  echo TLS_CACERT /etc/ldap/CAcert.pem > /etc/ldap/ldap.conf

ENTRYPOINT ["ucs-wordpress-entrypoint"]
COPY ucs-wordpress-entrypoint /usr/local/bin

# RUN set -ex; \
#   cd /var/www/html/wp-content/plugins && \
#   mv /root/authldap.zip . && \
#   unzip -o authldap.zip && \
#   chown -R www-data:www-data authldap && \
#   chown www-data:www-data authldap.zip
