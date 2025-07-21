# Use a specific version of the base image
FROM jc21/nginx-proxy-manager:2.9.16

# Switch to root user to install dependencies
USER root

# Install Python and Certbot Cloudflare plugin
RUN apk add --no-cache py3-pip \
  && pip install certbot-dns-cloudflare \
  && rm -rf /var/cache/apk/*

# Switch back to the non-root user
USER node
