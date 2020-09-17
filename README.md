# which.co.uk Technical Test 2.0a

A technical test around the use of docker and dynamic configuration.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Notes](#notes)

## Installation

Either build the container locally with docker.

```
cd docker/httpd-proxy && docker build -t which-tech-test:latest -f Dockerfile .
```

or grab the pre built container (complete with obscured name). 
 
```
docker pull davehewy/xmmgmtwauy:latest
docker tag davehewy/xmmgmtwauy:latest which-tech-test:latest
```

## Usage

Vanilla.

```
docker run -d --name "whichtest" which-tech-test:latest
```

For status page visit `http://localhost:8081/status`

For proxy configure browser to either `127.0.0.1:8080` or `localhost:8080`

Use different port mappings;

```
docker run -d --name "whichtest" -p 8090:8080 -p 8091:8081 which-tech-test:latest
```

The container supports the following env vars;

- **UNSET_HTTP_HEADER**
- **SET_HTTP_HEADER**
- **STATUS_REFRESH_PERIOD** (defaults to 1)

Example using all env vars

```
docker run -d -e UNSET_HTTP_HEADER="User-Agent" -e SET_HTTP_HEADER="User-Agent:tech-test" \
     -e "STATUS_REFRESH_PERIOD=3" --name "whichtest" -p 8090:8080 -p 8091:8081 \
     which-tech-test:latest
```

View the configs

```
docker exec whichtest cat /usr/local/apache2/conf/extra/httpd-vhosts.conf
docker exec whichtest cat /etc/cron.d/status-cron
```

Refer to the mandated test documentation for full implementation docs.

## Notes

- You will have by now hopefully have seen I am going to win no awards for the design of my status monitoring page.
- I choose a simple crontab implementation for stats generation on an interval. Limitation ofc here is that you may only configure the schedule in mins. ideally would never be doing something like this anyway :) did get tempted to install node_exporter and reverse proxy apache's /status to it (but alas, time)
- supervisor is being used to manage the multi service container. limitations ofc here in that this container should be split up. but since the test stated explicitly use a single container...