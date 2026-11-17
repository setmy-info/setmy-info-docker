# setmy-info-rocky-java-hsqldb

## Build

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-java-hsqldb:2.7.4 -t setmyinfo/setmy-info-rocky-java-hsqldb:latest .
```

## Execute

```shell
docker run --rm -p 9001:9001 setmyinfo/setmy-info-rocky-java-hsqldb:latest
docker run --rm -p 9001:9001 setmyinfo/setmy-info-rocky-java-hsqldb:latest hsqldb microservicedb
docker run --rm -p 9092:9092 -p 8082:8082 setmyinfo/setmy-info-rocky-java-hsqldb:latest h2
```

First parameter selects the server: **hsqldb** (default) or **h2**. Further parameters are passed to the server.

H2 TCP port **9092**, web console port **8082**, base directory **/var/opt/h2/data**, JDBC URL example
`jdbc:h2:tcp://localhost:9092/microservicedb`.

Database name **microservice** alias **db**.
