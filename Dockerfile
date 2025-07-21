# ===== Stage 1: Builder =====
FROM node:18-bullseye-slim AS builder

WORKDIR /app

# Cài gói cần thiết để clone + build + certbot plugin
RUN apt-get update && \
    apt-get install -y \
        git \
        python3-pip \
        python3-dev \
        build-essential \
        libffi-dev \
        libssl-dev \
        rustc \
        sqlite3 \
        sudo && \
    pip3 install --upgrade pip && \
    pip3 install certbot certbot-dns-cloudflare && \
    apt-get clean

# Clone source code NPM
RUN git clone --depth 1 https://github.com/NginxProxyManager/nginx-proxy-manager.git . && \
    npm install --omit=dev

# ===== Stage 2: Runtime =====
FROM node:18-slim

WORKDIR /app

# Cài pip và certbot plugin ở runtime
RUN apt-get update && \
    apt-get install -y \
        python3-pip \
        libffi-dev \
        libssl-dev \
        rustc \
        sqlite3 \
        sudo && \
    pip3 install --upgrade pip && \
    pip3 install certbot certbot-dns-cloudflare && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy từ builder stage
COPY --from=builder /app /app

# Mở port
EXPOSE 80 81 443

# Chạy app
CMD ["node", "index.js"]
