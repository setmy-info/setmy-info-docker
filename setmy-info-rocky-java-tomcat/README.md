# setmy-info-rocky-java-tomcat

Notes are mostly the same as
with [SMI Rocky linux](https://github.com/setmy-info/setmy.info/tree/develop/setmy-info-docker/setmy-info-rocky)

## Build

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-java-tomcat:11.0.29 -t setmyinfo/setmy-info-rocky-java-tomcat:latest .
```

## Execute

```shell
docker run --rm -p 8080:8080 setmyinfo/setmy-info-rocky-java-tomcat:latest
```

HTTP port **8080**, URL `http://localhost:8080/`.
