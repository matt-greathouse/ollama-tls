# Use a lightweight base image
FROM ubuntu:22.04

# Update package manager and upgrade system packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Copy SSL certificates
COPY server.crt /etc/ssl/certs/server.crt
COPY server.key /etc/ssl/private/server.key

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose ports for nginx
EXPOSE 80 443

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
