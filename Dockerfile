# Use an official NGINX runtime as a parent image
FROM nginx:latest

# Copy nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static content (HTML, JS, CSS, etc.) to NGINX web root directory
COPY html /usr/share/nginx/html

# Expose port 80 to allow outside access to NGINX server
EXPOSE 80

# Start NGINX server when the container launches
CMD ["nginx", "-g", "daemon off;"]
