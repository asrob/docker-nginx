FROM asrob/ubuntu-base:18.04

RUN add-apt-repository ppa:ondrej/nginx \
 && apt-get update \
 && apt-get install -y --no-install-recommends geoip-database nginx-extras libgeoip1 logrotate \
 && apt-get clean all \
 && rm -rf /var/lib/apt/lists/* \
 && mv /usr/share/GeoIP/GeoIP.dat /usr/share/GeoIP/GeoIP.dat_bak \
 && cd /usr/share/GeoIP/ \
 && wget https://dl.miyuru.lk/geoip/maxmind/country/maxmind.dat.gz \
 && gunzip maxmind.dat.gz \
 && mv maxmind.dat GeoIP.dat \
 && mkdir -p /etc/nginx/ssl \
 && groupmod -g 1001 www-data \
 && usermod -u 1001 www-data
COPY etc /etc
COPY init.sh /init.sh
EXPOSE 80 443
CMD ["/init.sh"]
