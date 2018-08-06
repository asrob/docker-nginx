FROM asrob/ubuntu-nginx:18.04

RUN add-apt-repository ppa:ondrej/nginx \
 && apt-get update \
 && apt-get install -y --no-install-recommends nginx-extras \
 && apt-get clean all \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /etc/nginx/ssl
COPY etc /etc
COPY init.sh /init.sh
RUN rm /etc/nginx/sites-enabled/default
# HEALTHCHECK --interval=30s --timeout=10s --start-period=30s CMD curl --fail http://localhost:80/ || exit 1
CMD ["/init.sh"]
