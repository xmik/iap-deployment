# iap-deployment

Deployment of 4 projects for the subject Internet Application Programming.

## Current status

This is a school project. Does not work yet.

## Deploy locally

First, download the code of 4 projects:
```
./tasks get_code
```

Then, run all servers and applications in 6 docker containers:
```
./tasks up
```

Check that all the containers are running:
```
docker ps -a
```

To stop the containers and remove all resources created by docker-compose:
```
./tasks down
```

## Dependencies
* [Docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)
