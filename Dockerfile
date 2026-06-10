FROM ghcr.io/eooce/nodejs:latest

WORKDIR /tmp

# Replace index.js with fixed version from fork repo
COPY index.js /tmp/index.js

EXPOSE 3000/tcp

CMD ["node", "index.js"]
