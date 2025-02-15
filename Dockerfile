# Use an official Node.js runtime as the base image
FROM node:18 AS build

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the entire project to the working directory
COPY . .

# Build the React app
RUN npm run build

# Use Nginx to serve the built React app
FROM nginx:alpine

# Copy the build output to Nginx's HTML folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port Nginx runs on
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
