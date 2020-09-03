# Modifies Bitnami's Wordpress image to enable missing Apache modules and remove bundled plugins

FROM bitnami/wordpress@sha256:c2ea09780e884c75c5d82770e2b8f5802763c459476cf28b46b121f3895789a0

USER root
RUN set -eu; \
# apache modules
    sed -i '/^#.* expires_module/s/^#//'    /opt/bitnami/apache/conf/httpd.conf; \
    sed -i '/^#.* ext_filter_module/s/^#//' /opt/bitnami/apache/conf/httpd.conf; \
# php extensions
    echo 'extension=imagick.so' > /opt/bitnami/php/etc/conf.d/imagick.ini; \
# remove pre-packaged plugins
    find /opt/bitnami/wordpress/wp-content/plugins -mindepth 1 -maxdepth 1 -not -name index.php -exec rm -rf {} \;

USER 1001
