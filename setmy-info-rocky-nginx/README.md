# Readme

## Build

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-nginx:11.0.15 -t setmyinfo/setmy-info-rocky-nginx:latest .
docker run --rm -p 80:80 -p 443:443 setmyinfo/setmy-info-rocky-nginx:latest
```
