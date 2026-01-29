# Use the lightweight Nginx Alpine image
FROM nginx:alpine

# Copy your local index.html into the Nginx default public directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80

# Nginx starts automatically, so no CMD is strictly needed, 
# but this is the default for clarity:
CMD ["nginx", "-g", "daemon off;"]