FROM node:alpine3.22

WORKDIR /tmp

# Download fixed index.js from fork repo (LWargo1218 with tunnel.yml fix)
ADD https://raw.githubusercontent.com/binxueoo/LWargo1218/main/index.js /tmp/index.js
ADD https://raw.githubusercontent.com/binxueoo/LWargo1218/main/package.json /tmp/package.json

# Install dependencies and required packages
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    chmod +x /tmp/index.js && \
    cd /tmp && npm install

EXPOSE 3000/tcp

CMD ["node", "index.js"]
