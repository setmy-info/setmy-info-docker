# setmy-info-rocky-java-hsqldb

## Build

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-java-hsqldb:2.7.4 -t setmyinfo/setmy-info-rocky-java-hsqldb:latest .
```

## Execute

```shell
docker run --rm -p 9001:9001 setmyinfo/setmy-info-rocky-java-hsqldb:latest
```

Database name **microservice** alias **db**.
