# Modifies Bitnami's Wordpress image to enable missing Apache modules and remove bundled plugins

FROM bitnami/wordpress@sha256:a78e1368705af0fd6c9c93b38ddc38761c4909ae14425d0f6b86239985f72581

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
