FROM ghcr.io/eooce/nodejs:main

# Download the fixed index.js from fork repo
ADD https://raw.githubusercontent.com/binxueoo/LWargo1218/main/index.js /tmp/index.js.fixed
RUN cp /tmp/index.js.fixed /app/index.js

WORKDIR /app
EXPOSE 3000/tcp
