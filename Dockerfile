FROM node:18-alpine

# Install system dependencies and cloudflared
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash sed wget tzdata file && \
    wget -L -o /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared && \
    echo "=== Cloudflared file info ===" && \
    file /usr/local/bin/cloudflared && \
    ls -la /usr/local/bin/cloudflared && \
    echo "=== Cloudflared version ===" && \
    /usr/local/bin/cloudflared --version && \
    echo "=== Done ==="

WORKDIR /app

COPY package.json /app/package.json
RUN npm install --production

COPY index.js /app/index.js
RUN mkdir -p /app/.tmp

EXPOSE 3000/tcp

CMD ["node", "/app/index.js"]
