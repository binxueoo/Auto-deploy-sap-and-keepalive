FROM ghcr.io/eooce/nodejs:latest

# Replace index.js with fixed version that writes tunnel.yml for token mode
COPY index.js /tmp/index.js

WORKDIR /tmp

CMD ["node", "index.js"]
