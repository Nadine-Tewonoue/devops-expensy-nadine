# ---------- Builder ----------
FROM node:20-alpine AS builder
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci

# 🔥 Build-time variable (VERY IMPORTANT)
ARG NEXT_PUBLIC_API_URL
ENV NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL

# Copy source code
COPY . .

# Build Next.js app
RUN npm run build


# ---------- Runner ----------
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

# Copy standalone output (requires output: "standalone")
COPY --from=builder /app/package*.json ./
RUN npm ci --omit=dev

COPY --from=builder /app/next.config.mjs ./next.config.mjs
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

EXPOSE 3000

CMD ["node", "node_modules/next/dist/bin/next", "start", "-p", "3000"]

#
#CMD ["node", "node_modules/next/dist/bin/next", "start", "-p", "3000"]



# Now it's your job, go through AI explain this is meant to be a next.js app that uses the following variable.
# The frontend must communicate with the backen (right now it's not because it doesn't have something called "build arguments")
# Ask AI to fix this

# Then rebuild the image, delete and recreate the deployment for the frontend!
# But right now the API is working!


# I'm using a tool called nip.io that resolves automatically to the address of the ip of the cluster
# for example 123.123.123.123.nip.io ---> 123.123.123.123


# NEXT_PUBLIC_API_URL=api.20.82.53.32.nip.io
# Now it's your turn, try copy pasting this file into the ai and follwing its next steps
