FROM jc21/nginx-proxy-manager:latest

# Cài đặt pip và certbot-dns-cloudflare
RUN apk add --no-cache \
    py3-pip \
    python3-dev \
    build-base \
    libffi-dev \
    openssl-dev \
    && pip3 install --upgrade pip \
    && pip3 install certbot-dns-cloudflare \
    && apk del build-base python3-dev libffi-dev openssl-dev

# Copy script khởi tạo tùy chỉnh (nếu cần)
# COPY custom-entrypoint.sh /custom-entrypoint.sh
# RUN chmod +x /custom-entrypoint.sh

# Expose ports
EXPOSE 80 443 81

# Sử dụng entrypoint gốc
ENTRYPOINT ["/usr/bin/entry.sh"]
