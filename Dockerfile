# Pin to specific n8n version for stability
FROM n8nio/n8n:1.94.1

# Switch to root for installation
USER root

# Install system dependencies
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    git

# Create a custom directory for external packages
RUN mkdir -p /home/node/custom_packages
WORKDIR /home/node/custom_packages

# Initialize a new package.json for our custom packages
RUN npm init -y

# Install the packages you need
RUN npm install \
    docxtemplater@3.39.0 \
    docxtemplater-image-module-free@1.1.1 \
    image-size@1.0.2 \
    fs-extra@10.1.0 \
    lodash@4.17.21 \
    moment@2.29.4 \
    axios@0.27.2 \
    cheerio@1.0.0-rc.5

# Create symbolic links in n8n's node_modules so they're discoverable
RUN mkdir -p /usr/local/lib/node_modules/n8n/node_modules
RUN ln -sf /home/node/custom_packages/node_modules/docxtemplater /usr/local/lib/node_modules/n8n/node_modules/docxtemplater
RUN ln -sf /home/node/custom_packages/node_modules/docxtemplater-image-module-free /usr/local/lib/node_modules/n8n/node_modules/docxtemplater-image-module-free
RUN ln -sf /home/node/custom_packages/node_modules/lodash /usr/local/lib/node_modules/n8n/node_modules/lodash
RUN ln -sf /home/node/custom_packages/node_modules/moment /usr/local/lib/node_modules/n8n/node_modules/moment
RUN ln -sf /home/node/custom_packages/node_modules/axios /usr/local/lib/node_modules/n8n/node_modules/axios
RUN ln -sf /home/node/custom_packages/node_modules/cheerio /usr/local/lib/node_modules/n8n/node_modules/cheerio
RUN ln -sf /home/node/custom_packages/node_modules/image-size /usr/local/lib/node_modules/n8n/node_modules/image-size
RUN ln -sf /home/node/custom_packages/node_modules/fs-extra /usr/local/lib/node_modules/n8n/node_modules/fs-extra

# Set NODE_PATH to include our custom packages
ENV NODE_PATH=/home/node/custom_packages/node_modules:$NODE_PATH

# Change ownership of custom packages directory
RUN chown -R node:node /home/node/custom_packages

# Switch back to node user
USER node

# Set working directory back to n8n default
WORKDIR /home/node

# Documentation
LABEL maintainer="cian.hanley@hotmail.co.uk"
LABEL description="n8n with essential packages for personal use"
LABEL packages="docxtemplater,lodash,moment,axios,cheerio,image-size"
