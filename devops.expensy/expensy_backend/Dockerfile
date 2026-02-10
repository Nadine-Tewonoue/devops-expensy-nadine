FROM node:20-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy source code
COPY . .

# Build backend (if using TypeScript)
RUN npm run build || echo "No build step, skipping"

# Expose backend port
EXPOSE 8706

CMD ["node", "dist/server.js"]