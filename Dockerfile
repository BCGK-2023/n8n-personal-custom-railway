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

# Set Puppeteer to use system Chromium (if needed later)
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Change to n8n directory
WORKDIR /usr/local/lib/node_modules/n8n

# Install packages in smaller groups to avoid conflicts
# Group 1: Document processing (known working)
RUN npm install \
    docxtemplater@3.50.0 \
    docxtemplater-image-module-free@1.1.1 \
    image-size@1.1.1 \
    fs-extra@11.2.0

# Group 2: Basic utilities (stable versions)
RUN npm install \
    lodash@4.17.21 \
    moment@2.29.4 \
    axios@0.27.2 \
    crypto-js@4.1.1 \
    uuid@9.0.1

# Group 3: File processing
RUN npm install \
    csv-parser@3.0.0 \
    xml2js@0.4.23

# Group 4: Web scraping (using older stable version)
RUN npm install \
    cheerio@1.0.0-rc.10

# Group 5: PDF processing (separate to isolate potential issues)
RUN npm install \
    pdf-lib@1.17.1

# Group 6: Image processing (install separately due to native dependencies)
RUN npm install \
    jimp@0.16.13

# Group 7: Try sharp (if this fails, we'll skip it)
RUN npm install sharp@0.32.6 || echo "Sharp failed to install, skipping..."

# Group 8: Other utilities
RUN npm install \
    dayjs@1.11.7 \
    bcrypt@5.1.0 || echo "Bcrypt failed to install, skipping..."

# Group 9: JSON/CSV processing
RUN npm install \
    json2csv@5.0.7 || echo "json2csv failed to install, skipping..."

# Create package info for tracking
RUN echo '{ \
  "name": "n8n-enhanced-packages", \
  "description": "Comprehensive n8n setup with commonly used packages for personal use", \
  "version": "2.0.0", \
  "packages_installed": "See individual RUN commands above" \
}' > /usr/local/lib/node_modules/n8n/enhanced-packages.json

# Switch back to node user
USER node

# Documentation
LABEL maintainer="cian.hanley@hotmail.co.uk"
LABEL description="n8n with comprehensive packages for personal use"
LABEL packages="docxtemplater,lodash,moment,axios,cheerio,crypto-js,uuid,image-size"
