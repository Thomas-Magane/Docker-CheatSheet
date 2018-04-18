# Use an official node runtime as a parent image
FROM node:latest

# creating folder for making as work directory
RUN mkdir -p /usr/src/app

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Copy package.json in current directory to work directory 
COPY package.json /usr/src/app/

# Install dependencies specified in package.json
RUN npm install

# Copy entire files in current directory to work directory
COPY . /usr/src/app

# Expose port 3000 for this container
EXPOSE 3000

# Command to start this container
CMD [ "npm", "start" ]