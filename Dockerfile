FROM jc21/nginx-proxy-manager:latest

USER root

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99no-check-valid-until

RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip3 install --upgrade pip setuptools

RUN pip3 install --no-cache-dir \
    cloudflare==2.8.15 \
    certbot-dns-cloudflare==1.21.0 \
    cryptography==3.4.8 \
    pyopenssl==20.0.1

RUN python3 -c "import CloudFlare; print('CloudFlare module OK')" && \
    python3 -c "import certbot_dns_cloudflare; print('certbot-dns-cloudflare OK')"

RUN certbot plugins --text | grep cloudflare || (echo "Cloudflare plugin not found!" && exit 1)

RUN mkdir -p /data/cloudflare && chmod 700 /data/cloudflare

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

USER node
