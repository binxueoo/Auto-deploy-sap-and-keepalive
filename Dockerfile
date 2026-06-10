FROM node:18-alpine

WORKDIR /tmp

# Copy files from build context
COPY index.js /tmp/index.js.raw
COPY package.json /tmp/package.json

# Remove BOM if present and set up the application
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash sed && \
    sed '1s/^\xEF\xBB\xBF//' /tmp/index.js.raw > /tmp/index.js && \
    chmod +x /tmp/index.js && \
    cd /tmp && npm install --production 2>&1 && \
    echo "=== Verifying installation ===" && \
    node -e "require('axios'); console.log('axios OK')" && \
    echo "=== Done ==="

EXPOSE 3000/tcp

CMD ["node", "index.js"]
