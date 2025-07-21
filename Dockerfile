FROM jc21/nginx-proxy-manager:latest

USER root

RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip3 install certbot-dns-cloudflare && \
    apt-get clean

USER node
