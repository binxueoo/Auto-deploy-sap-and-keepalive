FROM node:18-alpine

# Install system dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash sed wget tzdata file

# Download cloudflared binary using curl (handles GitHub redirects properly)
RUN curl -fsSL -o /usr/local/bin/cloudflared "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64" && \
    chmod +x /usr/local/bin/cloudflared && \
    file /usr/local/bin/cloudflared && \
    /usr/local/bin/cloudflared --version

WORKDIR /app

COPY package.json /app/package.json
RUN npm install --production

COPY index.js /app/index.js
RUN mkdir -p /app/.tmp

EXPOSE 3000/tcp

CMD ["node", "/app/index.js"]
