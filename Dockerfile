# Pin to specific n8n version for stability
FROM n8nio/n8n:1.94.1

# Switch to root for installation
USER root

# Install only essential system dependencies
RUN apk add --no-cache \
    python3 \
    make \
    g++

# Change to n8n directory
WORKDIR /usr/local/lib/node_modules/n8n

# Install packages one by one (safest approach)
RUN npm install docxtemplater@3.39.0
RUN npm install docxtemplater-image-module-free@1.1.1
RUN npm install image-size@1.0.2
RUN npm install fs-extra@10.1.0

# Add a few essential utilities (older, stable versions)
RUN npm install lodash@4.17.21
RUN npm install moment@2.29.4
RUN npm install axios@0.27.2

# Add cheerio for web scraping (older version)
RUN npm install cheerio@1.0.0-rc.5

# Switch back to node user
USER node

# Documentation
LABEL maintainer="cian.hanley@hotmail.co.uk"
LABEL description="n8n with essential packages for personal use"
LABEL packages="docxtemplater,lodash,moment,axios,cheerio,image-size"
