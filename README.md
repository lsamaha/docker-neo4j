# docker-neo4j

This docker file starts neo4j 2.2.0 on Debian in a Docker container.

## Host

The standard neo4j 7473 and 7474 ports are exposed. Just map them to host ports using docker's -p parameter.

```
docker run -d -p 7474:7474 lwsamaha/neo4j:latest
```

## Data

With docker, your data volume will be removed when your container is removed. To point docker at an existing directory, 
and ensure it is preserved after your container is removed, you can map a directory on your host to the volume declared 
in the docker container at /opt/neo4j/data.
Just run the container with -v and map your host directory to the container path.

```
docker run -v hostdir:/opt/neo4j/data -d -p 7474:7474 lwsamaha/neo4j:latest
```

## Logs

The logs are appended to standard out and are also available in the mounted volume via the docker logs command, or by retrieving the contents of the data directory at /opt/neo4j/data/log or your host mapped volume. 
If you've mapped the container data directory volume to a host directory, logs will be available after the container is removed.

_** Happy graphing! **_
