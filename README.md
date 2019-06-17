# iap-deployment

Deployment of 4 projects for the subject Internet Application Programming.

## Current status

This is a school project. Does not work yet.

## Deploy locally

### Get docker images

First, build all 4 docker images, using either this command:
```
./tasks build_hq_backend
./tasks build_bo_backend
./tasks build_hq_frontend
./tasks build_bo_frontend
```

or this command:
```
./tasks build_all
```

### Run the docker images

#### Start containers
Run all servers and applications in 6 docker containers:
```
./tasks up
```

Check that all the containers are running:
```
$ docker ps -a
CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS              PORTS                    NAMES
6b0bee6c742c        iap-bo-backend:0.1.0   "bash -c iap-bo-back…"   3 seconds ago       Up 2 seconds        0.0.0.0:8080->8080/tcp   iap_bo_1
1aa3fd645551        iap-hq-backend:0.1.0   "bash -c iap-hq-back…"   4 seconds ago       Up 1 second         0.0.0.0:8000->8000/tcp   iap_hq_1
d811caebc7f5        postgres:11.2-alpine   "docker-entrypoint.s…"   5 seconds ago       Up 3 seconds        5432/tcp                 iap_bodb_1
7c50dfd0f1d0        postgres:11.2-alpine   "docker-entrypoint.s…"   5 seconds ago       Up 4 seconds        5432/tcp                 iap_hqdb_1
```

#### Verify that API servers are listening and can answer
```
# Headquarters
curl -i -L localhost:8000/api/branch_offices/list
curl -i -L localhost:8000/api/employees/list/0

# Branch Office
curl -i -L localhost:8080/api/employees/list
curl -i -X POST localhost:8080/api/employees -d '{"email": "123@gmail.com", "name": "Alex Nowy"}' -H 'Content-Type: text/json; charset=utf-8'
curl -i -L localhost:8080/api/employees/list
```

#### Verify synchronization in BO from HQ
BO gets Employee objects from HQ.
```
# 1. Check that an Employee with email "mag123@wp.pl" does not exist in BO:
curl -i  localhost:8080/api/employees/list
# 2. Add an employee in HQ
curl -i -X POST localhost:8000/api/employees -d @examples/hq-emp.json -H 'Content-Type: text/json; charset=utf-8'
# 3. Check that it was added in HQ
curl -i -L localhost:8000/api/employees/list/0
# 4. Either wait for synchronization in BO or invoke it with:
curl -i -X POST localhost:8080/api/synchronize -d ''
# 5. Check that an Employee with email "mag123@wp.pl" exists in BO:
curl -i  localhost:8080/api/employees/list
```

#### Log messages
To view the log messages from 1 docker container:
```
docker logs iap_bo_1
```

#### Stop and remove the containers
To stop the containers and remove all resources created by docker-compose:
```
./tasks down
```


## Dependencies
* [Docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)
* either [Dojo](https://github.com/ai-traders/dojo) or dotnet to compile the iap-bo-backend project
