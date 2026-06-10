FROM node:alpine3.22

WORKDIR /app

# Download fixed index.js from fork repo (LWargo1218 with tunnel.yml fix)
ADD https://raw.githubusercontent.com/binxueoo/LWargo1218/main/index.js /app/index.js
ADD https://raw.githubusercontent.com/binxueoo/LWargo1218/main/package.json /app/package.json

# Install dependencies and required packages
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    chmod +x /app/index.js && \
    cd /app && npm install

EXPOSE 3000/tcp

CMD ["node", "index.js"]
