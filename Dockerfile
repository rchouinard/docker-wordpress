# Modifies Bitnami's Wordpress image to enable missing Apache modules and remove bundled plugins

FROM bitnami/wordpress@sha256:83d937027a77d1511caf6412f2b37d7fc4145e69f11f3363d3006a28296ae268

USER root
RUN set -eu; \
# apache modules
    sed -i '^#.* expires_module/s/^#//'    /opt/bitnami/apache/conf/httpd.conf; \
    sed -i '^#.* ext_filter_module/s/^#//' /opt/bitnami/apache/conf/httpd.conf; \
# remove pre-packaged plugins
    find /opt/bitnami/wordpress/wp-content/plugins -mindepth 1 -maxdepth 1 -not -name index.php -exec rm -rf {} \;

USER 1001
