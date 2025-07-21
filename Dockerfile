FROM jc21/nginx-proxy-manager:latest

# Cài đặt pip và certbot-dns-cloudflare
RUN apt-get update && \
        apt-get install -y python3-pip python3-dev build-essential libffi-dev libssl-dev && \
        pip3 install --upgrade pip && \
        pip3 install certbot-dns-cloudflare && \
        apt-get remove -y python3-dev build-essential libffi-dev libssl-dev && \
        apt-get autoremove -y && \
        apt-get clean;

# Expose ports
EXPOSE 80 443 81

# Sử dụng entrypoint gốc
ENTRYPOINT ["/init"]
