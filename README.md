# Docker CheatSheet
An ultimate guide for Docker commands

### Listing Commands
List all images that are locally stored with the Docker engine

```
docker images
```
List all the running containers

```
docker ps
```
List all the networks

```
docker network ls
```
### Build Commands
Build an image from the Dockerfile in the current directory and tag the image

```
docker build -t myapp:latest .
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
### Stop Command
Stop a running container

```
docker stop myapp
```
Stop a running container through SIGKILL

```
docker kill myapp
```
### Excecute Commands
Create a process inside the container
```
docker exec -it <conatiner_name> <process_command>
```
