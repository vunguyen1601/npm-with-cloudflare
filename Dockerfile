# Stage 1: Clone và build nginx-proxy-manager từ source
FROM node:18-alpine as builder

WORKDIR /app

RUN apk add --no-cache git python3 py3-pip make gcc g++ linux-headers

# Clone source
RUN git clone --depth=1 https://github.com/NginxProxyManager/nginx-proxy-manager.git .

# Cài đặt dependencies
RUN cd backend && npm install && npm run build

# Stage 2: Final image từ Alpine + NPM + Cloudflare support
FROM jc21/nginx-proxy-manager:latest

# Cài thêm pip và cloudflare
RUN pip install certbot certbot-dns-cloudflare \
    && mkdir -p /etc/letsencrypt

# (Optional) Copy cấu hình Cloudflare credentials nếu bạn dùng
# COPY ./cloudflare.ini /etc/letsencrypt/cloudflare.ini
# RUN chmod 600 /etc/letsencrypt/cloudflare.ini
