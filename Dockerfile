FROM n8nio/n8n

# Switch to root to install packages
USER root

# Install required packages
RUN npm install -g \
    docxtemplater \
    docxtemplater-image-module-free \
    image-size \
    fs-extra

# Switch back to node user
USER node
