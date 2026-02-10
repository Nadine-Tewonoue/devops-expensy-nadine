# Stage 1: Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install all dependencies (including devDependencies)
RUN npm install

# Copy source code
COPY . .

# Build Next.js
RUN npm run build

# Stage 2: Production image
FROM node:20-alpine

WORKDIR /app

# Copy only the production-ready files from builder
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules

# Set production environment
ENV NODE_ENV=production
EXPOSE 3000

# Start Next.js server
CMD ["npx", "next", "start"]

