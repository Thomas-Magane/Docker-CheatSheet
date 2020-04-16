# Docker CheatSheet <img src="https://github.com/vishnusudarsan/Docker-CheatSheet/blob/master/docker.png" width="50px"/>
An ultimate guide for Docker with extremely useful docker commands.

<img src="https://github.com/vishnusudarsan/Docker-CheatSheet/blob/master/docker-architecture.png"/>

## Glossary
- **Layer** - a set of read-only files to provision the system
- **Image** - a read-only layer that is the base of your container.Might have a parent image
- **Container** -  a runnable instance of the image
- **Registry / Hub** -  central place where images live
- **Docker machine** -  a VM to run Docker containers (Linux does this natively)
- **Docker compose** -   a utility to run multiple containers as a system

### Docker Commands
#### Listing Commands
List all docker commands
```
docker --help
```
Display Docker version
```
docker --version /* Show the Docker version information */
docker -v /* Show the Docker version information */
```
Display system-wide information
```
Usage: docker info [OPTIONS]

Options:
  -f, --format string   Format the output using the given Go template
```
List all images that are locally stored with the Docker engine

Example: docker info
```
Usage:	docker images [OPTIONS] [REPOSITORY[:TAG]]

List images

Options:
  -a, --all             Show all images (default hides intermediate images)
      --digests         Show digests
  -f, --filter filter   Filter output based on conditions provided
      --format string   Pretty-print images using a Go template
      --no-trunc        Don't truncate output
  -q, --quiet           Only show numeric IDs

Example:
docker images /* List images */
docker images -a /* Show all images (default hides intermediate images) */
docker images -aq /* Show all images ids */
```
List Docker containers (running, all, all in quiet mode)
```
docker container ls
docker container ls --all /* Show all container (default hides intermediate containers)*/
docker container ls -aq /* Show all container ids */
```
List all containers

```
docker ps /* Show all running containers */
docker ps -a /* Show all containers */
```
List all the networks

```
docker network ls
```
Download an image

```
docker pull image_name
```

Rename a Docker Container

```
docker rename node_v1 node_v2
```

### Docker machine commands
Use docker-machine to run the containers 
Start a machine
```
docker-machine start machine_name
```
Configure docker to use a specific machine
```
eval "$(docker-machine env machine_name)"
```

### Start/Stop Command
Start/Stop a running container

```
docker [start|stop] container_name
```
Kill all running containers
```
docker kill $(docker ps -q)
```
Pause a Container
```
docker pause container_name
```
UnPaise a Paused Container
```
docker unpause container_name
```

### Build Commands
Build an image from the Dockerfile in the current directory and tag the image

```
docker build -t myapp:latest . 
```

### Run the app
Create/Start docker container and Create/Start docker contaier in a specific port
```
docker run <container_name>:<tag_name>
docker run -p <port_name>:<port_name> <container_name>
docker run -d --name <container_name> -p <port> <image_name>:<tag_name> /* Expose container but on a randomly available port */
docker run -d --name <container_name> -p <port_name>:<port_name> <image_name>:<tag_name>
```
Run command will always create a container. Examples of Run command based on the above order : 
```
docker run -d redis:latest
docker run -p 3000:80 myapp
docker run -d --name redisDynamic -p 6379 redis:latest
docker run -d --name redisHostPort -p 6379:6379 redis:latest
```
Create and start container, run command
```
docker run -ti --name container_name image_name command
```
Link the created container with other containers
```
docker run --name <container_name> --restart always -p <port_name>:<port_name> --link <container_name_1> --net <network_name> --link <hostname> -d <container_name>
```

### Logging
For more details about a running container
```
docker inspect <friendly-name|container-id>
```
Display messages the container has written to standard error or standard out.
```
docker logs <friendly-name|container-id>
```
Port information of a container
```
docker port <friendly-name|container-id> <port>
```
### Delete Commands
Delete an image from the local image store

```
docker rmi myapp:latest
```
Delete all running and stopped containers 

```
docker rm -f $(docker ps -aq)
```
Delete dangling images

```
docker rmi $(docker images -q -f dangling=true)
 ```
Removing all the Containers

```
docker rm `docker ps --no-trunc -aq`
```
Delete all images
```
docker rmi $(docker images -a -q)
```

### Excecute Commands
Create a process inside the container
```
docker exec -it <conatiner_name> <process_command>
```
Example
```
docker exec -it <conatiner_name> bash
```

### Export/Import Data Container
```
docker export dataContainer > dataContainer.tar
docker import dataContainer.tar
```

### Dockerfile
```
# Use an official node runtime as a parent image - Define the base image
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
```

### Docker compose syntax
docker-compose.yml file example

```
version: '3'
services:
  app:
    build:
      context: ./docker/app
      dockerfile: Dockerfile
    image: shippingdocker/app:latest
    networks:
     - appnet
    volumes:
     - .:/var/www/html
    ports:
     - ${APP_PORT}:80
    working_dir: /var/www/html
  cache:
    image: redis:alpine
    networks:
     - appnet
    volumes:
     - cachedata:/data
  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: homestead
      MYSQL_USER: homestead
      MYSQL_PASSWORD: secret
    ports:
     - ${DB_PORT}:3306
    networks:
     - appnet
    volumes:
     - dbdata:/var/lib/mysql
  node:
    build:
      context: ./docker/node
      dockerfile: Dockerfile
    image: shippingdocker/node:latest
    networks:
     - appnet
    volumes:
     - .:/opt
    working_dir: /opt
    command: echo hi
networks:
  appnet:
    driver: bridge
volumes:
  dbdata:
    driver: local
  cachedata:
    driver: local
 ```
Create and start containers
 
```
docker-compose up
```
