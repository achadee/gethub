# Gethub

Gethub is a simple Rails project that pulls down Github repos for fast searching


## Getting Started

This project runs on Docker, so you can run it on a container service like [ECS]( https://aws.amazon.com/ecs/) or you can run it locally buy [installing docker](https://docs.docker.com/install/) on your machine


### Installing

Clone the repo into a folder of your choice

```
git clone https://github.com/achadee/gethub
```
Build the containers!

```
docker-compose build
```

### Usage

To start the service on docker-compose run the docker-compose up command if you havn't already

```
docker-compose up -d
```

You can test if the service is running by running the `docker ps` command

```bash
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
ca794496e0f2        gethub_web          "run.sh bash -c 'rm …"   25 hours ago        Up 24 hours         0.0.0.0:3000->3000/tcp   gethub_web_1
```

There should be 1 service running on the container

## Viewing github repos

Public repos can be accessed locally via [localhost:3000/repos](http://localhost:3000/repos)

Github's search API does not support pagination, so we only display the first 30 results

## Running the tests

You can run tests by running the command

```
docker exec -it gethub_web_1 rails test
```
## Design choices

### Models

<b>Repo</b>

A non active record class that stores values in memory

|field|description|type|
|-----|-----------|----|
|id | Github unique identifier | Integer |
|name | Preview name of the repo | String |
|full_name |full name, could be a Github organisation | String |
|html_url | link to the repo | URI |
|user_name | user that created the repo | String |
