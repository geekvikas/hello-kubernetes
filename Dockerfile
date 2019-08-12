# Take smallest, node build
FROM node:alpine           

# Copy package file first, to install the dependencies, 
# in case of failure, we will save time from transfering files
COPY package.json package.json

# Install dependencies
RUN npm install 

# Copy app source
COPY . . 

# Expose port 
EXPOSE 3000

# Default run command
CMD [ "npm", "start" ]