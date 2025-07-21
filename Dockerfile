FROM jc21/nginx-proxy-manager:latest

# Cài đặt pip và certbot-dns-cloudflare
RUN apk update && apk add --no-cache \
    py3-pip \
    python3-dev \
    build-base \
    libffi-dev \
    openssl-dev \
    rust \
    cargo \
    && pip3 install --upgrade pip \
    && pip3 install certbot-dns-cloudflare \
    && apk del build-base python3-dev libffi-dev openssl-dev rust cargo \
    && rm -rf /var/cache/apk/*

# Expose ports
EXPOSE 80 443 81

# Sử dụng entrypoint gốc
ENTRYPOINT ["/init"]
