# Modifies Bitnami's Wordpress image to enable missing Apache modules and remove bundled plugins

FROM bitnami/wordpress@sha256:d4b888ad309f645c626e74b61ee4db65463c067ba795eef7128bcce5d38ae14b

USER root
RUN set -eu; \
# apache modules
    sed -i '^#.* expires_module/s/^#//'    /opt/bitnami/apache/conf/httpd.conf; \
    sed -i '^#.* ext_filter_module/s/^#//' /opt/bitnami/apache/conf/httpd.conf; \
# remove pre-packaged plugins
    find /opt/bitnami/wordpress/wp-content/plugins -mindepth 1 -maxdepth 1 -not -name index.php -exec rm -rf {} \;

USER 1001
