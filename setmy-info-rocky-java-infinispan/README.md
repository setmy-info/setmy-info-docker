# setmy-info-rocky-java-infinispan

## Build

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-java-infinispan:16.3.1 -t setmyinfo/setmy-info-rocky-java-infinispan:latest .
```

## Execute

```shell
docker run --rm -p 11222:11222 setmyinfo/setmy-info-rocky-java-infinispan:latest
docker run --rm -it -p 11222:11222 -p 7800:7800 -p 11221:11221 -p 8181:8080 -p 9990:9990 setmyinfo/setmy-info-rocky-java-infinispan:latest
```

Hot Rod, REST and web console port **11222**, web console URL `http://localhost:11222/console`.

User **admin**, or INFINISPAN_USER. The password is INFINISPAN_PASSWORD, or generated and printed in the container log at start:

```shell
docker run --rm -p 11222:11222 -e INFINISPAN_PASSWORD=secret setmyinfo/setmy-info-rocky-java-infinispan:latest
```
