# Pin to specific n8n version for stability
FROM n8nio/n8n:1.94.1

# Switch to root for installation
USER root

# Install system dependencies for various packages
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    ffmpeg \
    imagemagick-dev \
    imagemagick \
    py3-pip \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Set Puppeteer to use system Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Change to n8n directory and install npm packages
WORKDIR /usr/local/lib/node_modules/n8n

# Install essential packages that most people need
RUN npm install \
    # Document processing
    docxtemplater@3.50.0 \
    docxtemplater-image-module-free@1.1.1 \
    pdf-lib@1.17.1 \
    # Web scraping & HTTP
    cheerio@1.0.0-rc.12 \
    axios@1.7.2 \
    # Data manipulation
    lodash@4.17.21 \
    moment@2.30.1 \
    dayjs@1.11.11 \
    # Image processing
    sharp@0.33.4 \
    jimp@0.22.12 \
    image-size@1.1.1 \
    # File handling
    fs-extra@11.2.0 \
    csv-parser@3.0.0 \
    # Crypto & utilities
    crypto-js@4.2.0 \
    uuid@10.0.0 \
    bcrypt@5.1.1 \
    # JSON/XML processing
    xml2js@0.6.2 \
    json2csv@6.1.0

# Install browser automation (optional - only if you need it)
# RUN npm install puppeteer@23.11.1

# Create package info for tracking
RUN echo '{ \
  "name": "n8n-enhanced-packages", \
  "description": "Comprehensive n8n setup with commonly used packages for personal use", \
  "dependencies": { \
    "docxtemplater": "^3.50.0", \
    "docxtemplater-image-module-free": "^1.1.1", \
    "pdf-lib": "^1.17.1", \
    "cheerio": "^1.0.0-rc.12", \
    "axios": "^1.7.2", \
    "lodash": "^4.17.21", \
    "moment": "^2.30.1", \
    "dayjs": "^1.11.11", \
    "sharp": "^0.33.4", \
    "jimp": "^0.22.12", \
    "image-size": "^1.1.1", \
    "fs-extra": "^11.2.0", \
    "csv-parser": "^3.0.0", \
    "crypto-js": "^4.2.0", \
    "uuid": "^10.0.0", \
    "bcrypt": "^5.1.1", \
    "xml2js": "^0.6.2", \
    "json2csv": "^6.1.0" \
  } \
}' > /usr/local/lib/node_modules/n8n/enhanced-packages.json

# Switch back to node user
USER node

# Documentation
LABEL maintainer="cian.hanley@hotmail.co.uk"
LABEL description="n8n with comprehensive package for personal use"
LABEL packages="docxtemplater,pdf-lib,cheerio,axios,lodash,moment,sharp,crypto-js,uuid,bcrypt"
