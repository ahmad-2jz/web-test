# Use a small base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy the rest of the app
COPY . .

# Expose the app's port (if different, change it)
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
