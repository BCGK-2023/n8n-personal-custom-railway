# n8n Comprehensive Setup for Personal Use

A **feature-complete n8n Docker image** with pre-installed npm packages for document processing, web scraping, image manipulation, data processing, and more.

> **Perfect for:** Personal automation projects, document generation, web scraping, data processing, and advanced workflow automation.

## 🎯 **What This Is**

This is a **custom n8n Docker image** that extends the official `n8nio/n8n` image with **20+ popular npm packages** that are commonly needed for automation workflows but not included by default.

**Instead of manually installing packages one by one, this gives you everything you need out of the box.**

## 📦 **Included Packages**

### **Document Processing**
- **`docxtemplater`** - Generate Word documents from templates
- **`docxtemplater-image-module-free`** - Add images to Word documents  
- **`pdf-lib`** - Create, modify, and merge PDF files
- **`xml2js`** - Parse and convert XML data
- **`json2csv`** - Convert JSON to CSV and vice versa

### **Web Scraping & HTTP**
- **`cheerio`** - Server-side jQuery for HTML parsing
- **`axios`** - Advanced HTTP client with better error handling

### **Data Manipulation**
- **`lodash`** - Utility library for data processing
- **`moment`** - Date/time parsing and formatting (legacy support)
- **`dayjs`** - Modern lightweight date library

### **Image & Media Processing**
- **`sharp`** - High-performance image processing (resize, crop, format conversion)
- **`jimp`** - Pure JavaScript image editing
- **`image-size`** - Get image dimensions
- **`ffmpeg`** (system) - Video/audio processing

### **Security & Utilities**
- **`crypto-js`** - Encryption, hashing, and cryptographic functions
- **`uuid`** - Generate unique identifiers
- **`bcrypt`** - Secure password hashing
- **`fs-extra`** - Enhanced file system operations

### **File Processing**
- **`csv-parser`** - Parse CSV files efficiently

## 🚀 **Quick Deploy to Railway**

### **Option 1: One-Click Deploy**
[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/YOUR_TEMPLATE_ID)

### **Option 2: Manual Deploy**
1. **Fork this repository** to your GitHub account
2. **Sign up for [Railway](https://railway.app)** (free tier available)
3. **Create New Project** → **Deploy from GitHub**
4. **Select this repository**
5. **Add these environment variables:**
   ```bash
   NODE_FUNCTION_ALLOW_EXTERNAL=*
   N8N_ENCRYPTION_KEY=your-secret-key-here
   ```
6. **Deploy!** Railway will automatically build the Docker image

### **For Production/Persistent Setup:**
Add a PostgreSQL database and Redis for queue mode:
1. **Add PostgreSQL** service in Railway
2. **Add Redis** service in Railway  
3. **Update environment variables** (see full config below)

## ⚙️ **Environment Variables**

### **Minimal Setup (for testing):**
```bash
NODE_FUNCTION_ALLOW_EXTERNAL=*
N8N_ENCRYPTION_KEY=your-secret-encryption-key
```

### **Production Setup with Database:**
```bash
# Allow all npm packages in Code nodes
NODE_FUNCTION_ALLOW_EXTERNAL=*

# Database (PostgreSQL)
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=your-postgres-host
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=your-user
DB_POSTGRESDB_PASSWORD=your-password

# Security
N8N_ENCRYPTION_KEY=your-32-character-encryption-key

# Basic settings
N8N_EDITOR_BASE_URL=https://your-domain.com
WEBHOOK_URL=https://your-domain.com
```

## 💻 **How to Use the Packages**

Once deployed, you can use any of the included packages in **Code nodes**:

### **Example: Generate Word Document with Image**
```javascript
const Docxtemplater = require('docxtemplater');
const ImageModule = require('docxtemplater-image-module-free');
const fs = require('fs-extra');

// Your docxtemplater code here
// Full examples in the docs below
```

### **Example: Web Scraping**
```javascript
const cheerio = require('cheerio');
const axios = require('axios');

const response = await axios.get('https://example.com');
const $ = cheerio.load(response.data);
const title = $('title').text();

return [{json: {title}}];
```

### **Example: Image Processing**
```javascript
const sharp = require('sharp');

// Resize an image
const resizedImage = await sharp(inputImage)
  .resize(800, 600)
  .jpeg({quality: 80})
  .toBuffer();

return [{json: {image: resizedImage.toString('base64')}}];
```

## 🔧 **Adding More Packages**

To add additional npm packages:

1. **Edit the Dockerfile** in this repository
2. **Add your package** to the `RUN npm install` section:
   ```dockerfile
   RUN npm install \
       # ... existing packages ...
       your-new-package@1.0.0
   ```
3. **Commit and push** - Railway will automatically rebuild

## 🛠️ **Local Development**

To test this setup locally:

```bash
# Clone the repository
git clone https://github.com/your-username/n8n-custom-railway
cd n8n-custom-railway

# Build the Docker image
docker build -t n8n-custom .

# Run with basic setup
docker run -it --rm \
  -p 5678:5678 \
  -e NODE_FUNCTION_ALLOW_EXTERNAL=* \
  -e N8N_ENCRYPTION_KEY=test-key-for-local-dev \
  n8n-custom

# Open http://localhost:5678
```

## 📚 **Package Documentation**

- **[docxtemplater](https://docxtemplater.readthedocs.io/)** - Word document generation
- **[pdf-lib](https://pdf-lib.js.org/)** - PDF creation and manipulation  
- **[cheerio](https://cheerio.js.org/)** - Server-side jQuery
- **[axios](https://axios-http.com/)** - HTTP client
- **[lodash](https://lodash.com/)** - Utility functions
- **[sharp](https://sharp.pixelplumbing.com/)** - Image processing
- **[moment](https://momentjs.com/)** / **[dayjs](https://day.js.org/)** - Date handling

## 🐛 **Troubleshooting**

### **"Cannot find module" Error**
- Check that `NODE_FUNCTION_ALLOW_EXTERNAL=*` is set
- Verify the package name is correct
- Try redeploying the service

### **Image Processing Issues**
- For `sharp` errors, the system dependencies are included
- For `jimp`, no additional setup needed (pure JavaScript)

### **Browser Automation**
- Chromium is pre-installed
- To add Puppeteer, uncomment the line in the Dockerfile
- System Chromium path: `/usr/bin/chromium-browser`

### **Memory Issues**
- Increase Railway service memory if processing large files
- Consider using `sharp` instead of `jimp` for better performance

## 🎯 **Use Cases**

This setup is perfect for:

- **📄 Document Generation** - Automated reports, invoices, contracts
- **🖼️ Image Processing** - Thumbnails, watermarks, format conversion  
- **🕷️ Web Scraping** - Data extraction from websites
- **📊 Data Processing** - CSV/JSON transformation, analysis
- **🔐 Security Operations** - Hashing, encryption, token generation
- **📱 API Integration** - Advanced HTTP requests with retry logic
- **🎬 Media Processing** - Basic video/audio manipulation

## 📝 **Version History**

- **v1.0** - Initial setup with docxtemplater
- **v2.0** - Comprehensive package suite (current)

## 🤝 **Contributing**

Found a useful package that should be included? 

1. Fork this repository
2. Add the package to the Dockerfile
3. Update this README
4. Submit a pull request

## 📄 **License**

This project is open source. The included packages maintain their respective licenses.

## 👤 **Maintainer**

**Cian Hanley** - cian.hanley@hotmail.co.uk

*Built for personal automation workflows. Shared for the community.*

---

**⭐ If this helped you, please star the repository!**
