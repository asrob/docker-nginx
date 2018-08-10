FROM asrob/ubuntu-base:18.04

RUN add-apt-repository ppa:ondrej/nginx \
 && apt-get update \
 && apt-get install -y --no-install-recommends nginx-extras \
 && apt-get clean all \
 && rm -rf /var/lib/apt/lists/* \
 && rm /etc/nginx/sites-enabled/default
 && mkdir -p /etc/nginx/ssl
COPY etc /etc
COPY init.sh /init.sh
EXPOSE 80 443
CMD ["/init.sh"]
