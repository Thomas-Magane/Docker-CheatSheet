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

### Useful Commands
List Docker CLI commands
```
docker
docker container --help
```
Display Docker version and info
```
docker --version
docker version
docker info
```

List all images that are locally stored with the Docker engine

```
docker image ls
docker images
docker images --all  /* Show all images (default hides intermediate images) */
docker images -a /* Show all images (default hides intermediate images) */
```
List Docker containers (running, all, all in quiet mode)
```
docker container ls
docker container ls --all
docker container ls -aq
```
List all the running containers

```
docker ps
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

### Excecute Commands
Create a process inside the container
```
docker exec -it <conatiner_name> <process_command>
```
Example
```
docker exec -it <conatiner_name> bash
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
version: "3"
services:
  web:
    # replace username/repo:tag with your name and image details
    image: username/repo:tag
    deploy:
      replicas: 5
      resources:
        limits:
          cpus: "0.1"
          memory: 50M
      restart_policy:
        condition: on-failure
    ports:
      - "80:80"
    networks:
      - webnet
networks:
  webnet:
 ```
Create and start containers
 
```
docker-compose up
```
