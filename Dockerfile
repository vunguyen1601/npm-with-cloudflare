FROM jc21/nginx-proxy-manager:latest

USER root

RUN apk add --no-cache py3-pip \
  && pip install certbot-dns-cloudflare

USER node
