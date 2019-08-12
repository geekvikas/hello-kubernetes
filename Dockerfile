FROM node:alpine
COPY package.json package.json
RUN npm install 

# Copy app source
COPY . . 

# Expose port 
EXPOSE 3000

# Default run command
CMD [ "npm", "start" ]