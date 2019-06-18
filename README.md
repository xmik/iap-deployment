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
c44a8ab7dd1b        iap-hq-frontend:0.1.0              "bash -c run.sh"         About a minute ago   Up About a minute   0.0.0.0:3001->3001/tcp   iap_hqfr_1
38587d7410bf        iap-hq-backend:0.1.0               "bash -c iap-hq-back…"   About a minute ago   Up About a minute   0.0.0.0:8000->8000/tcp   iap_hq_1
1e514c54d85a        iap-bo-frontend:0.1.0              "bash -c run.sh"         About a minute ago   Up About a minute   0.0.0.0:3000->3000/tcp   iap_bofr_1
6e7bc3aea868        iap-bo-backend:0.1.0               "bash -c iap-bo-back…"   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp   iap_bo_1
1f3f70f7a7fb        postgres:11.2-alpine               "docker-entrypoint.s…"   About a minute ago   Up About a minute   5432/tcp                 iap_hqdb_1
726608095ad7        postgres:11.2-alpine               "docker-entrypoint.s…"   About a minute ago   Up About a minute   5432/tcp                 iap_bodb_1
```

#### Verify that API servers are listening and can answer
```
# Headquarters
curl -i -L localhost:8000/api/branch_offices/list
curl -i -L localhost:8000/api/employees/list/1

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
curl -i -L localhost:8000/api/employees/list/1
# 4. Either wait for synchronization in BO or invoke it with:
curl -i -X POST localhost:8080/api/synchronize -d ''
# 5. Check that an Employee with email "mag123@wp.pl" exists in BO:
curl -i  localhost:8080/api/employees/list
```

#### Add many employees to HQ
```
curl -i -X POST localhost:8000/api/employees -d @examples/hq-emp.json -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8000/api/employees -d @examples/hq-emp0.json -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8000/api/employees -d @examples/hq-emp1.json -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8000/api/employees -d @examples/hq-emp2.json -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8000/api/employees -d @examples/hq-emp3.json -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8000/api/employees -d @examples/hq-emp4.json -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8000/api/employees -d @examples/hq-emp5.json -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8000/api/employees -d @examples/hq-emp6.json -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8000/api/employees -d @examples/hq-emp7.json -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8000/api/employees -d @examples/hq-emp8.json -H 'Content-Type: text/json; charset=utf-8'
```

Verify that added:
```
curl -i -L localhost:8000/api/employees/list/1
```
Verify that synchronized into BO:
```
curl -i  localhost:8080/api/employees/list
```

### Add many employee hours to BO
For 3 employees:

```
curl -i -X POST localhost:8080/api/employee_hours -d '{"value": "100", "employeeId": "1", "timePeriod": "17.06.2019-23.06.2019" }' -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8080/api/employee_hours -d '{"value": "100", "employeeId": "2", "timePeriod": "17.06.2019-23.06.2019" }' -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8080/api/employee_hours -d '{"value": "100", "employeeId": "3", "timePeriod": "17.06.2019-23.06.2019" }' -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8080/api/employee_hours -d '{"value": "100", "employeeId": "1", "timePeriod": "24.06.2019-01.07.2019" }' -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8080/api/employee_hours -d '{"value": "100", "employeeId": "2", "timePeriod": "24.06.2019-01.07.2019" }' -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8080/api/employee_hours -d '{"value": "100", "employeeId": "3", "timePeriod": "24.06.2019-01.07.2019" }' -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8080/api/employee_hours -d '{"value": "100", "employeeId": "1", "timePeriod": "02.07.2019-09.07.2019" }' -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8080/api/employee_hours -d '{"value": "100", "employeeId": "2", "timePeriod": "02.07.2019-09.07.2019" }' -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8080/api/employee_hours -d '{"value": "100", "employeeId": "3", "timePeriod": "02.07.2019-09.07.2019" }' -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8080/api/employee_hours -d '{"value": "100", "employeeId": "1", "timePeriod": "10.07.2019-15.07.2019" }' -H 'Content-Type: text/json; charset=utf-8'
curl -i -X POST localhost:8080/api/employee_hours -d '{"value": "100", "employeeId": "1", "timePeriod": "02.02.2019-09.02.2019" }' -H 'Content-Type: text/json; charset=utf-8'
```

Verify that added:
```
curl -i  localhost:8080/api/employee_hours/list_all
```
Verify that migrated to BO:
```
curl -i -L localhost:8000/api/employee_hours/list
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
