FROM node:18-alpine

# Install cloudflared and system dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash sed wget tzdata && \
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared && \
    cloudflared --version

WORKDIR /app

# Copy package.json first for better caching
COPY package.json /app/package.json

# Install npm dependencies
RUN npm install --production

# Copy application files
COPY index.js /app/index.js

# Create .tmp directory for runtime files
RUN mkdir -p /app/.tmp

EXPOSE 3000/tcp

CMD ["node", "/app/index.js"]
