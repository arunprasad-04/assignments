# Use lightweight Nginx image
FROM nginx:alpine

# Copy all HTML files into Nginx's default web folder
COPY . /usr/share/nginx/html

# Expose port 80 to access the website
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]