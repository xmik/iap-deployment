# iap-deployment

Deployment of 4 projects for the subject Internet Application Programming.

## Current status

This is a school project. Does not work yet.

## Deploy locally

Then, run all servers and applications in 6 docker containers:
```
./tasks up
```

Check that all the containers are running:
```
docker ps -a
```

Verify that API servers are listening and can answer:
```
# Headquarters
curl -i -L localhost:8000/api/branch_offices
# Branch Office
curl -i -L localhost:8080/api/employees/list
```

To stop the containers and remove all resources created by docker-compose:
```
./tasks down
```

To build the needed docker images:
```
./tasks get_code
```
and follow the readme of each project.

## Dependencies
* [Docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)
