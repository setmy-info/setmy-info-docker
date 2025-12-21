# Readme

## Build

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-nginx:11.0.15 -t setmyinfo/setmy-info-rocky-nginx:latest .
docker run --rm -p 80:80 -p 443:443 setmyinfo/setmy-info-rocky-nginx:latest
```

## TODO

```
location /tomcat-start-project/ {
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://tomcat-start-project:8080/tomcat-start-project-1.2.0-SNAPSHOT/;
    proxy_set_header X-Real-IP $remote_addr;
    #proxy_hide_header Server;
    #proxy_pass_header Server;
    proxy_set_header Server "Apache/2.4.54 (Unix)";
    proxy_pass_header Set-Cookie;
    proxy_set_header Host $http_host;
    proxy_set_header X-Powered-By "IIS/10.0";  
    proxy_hide_header X-AspNet-Version;
    proxy_hide_header X-AspNetMvc-Version;
    proxy_hide_header X-Runtime;
    proxy_hide_header X-AspNetCore-Version;
    add_header Cache-Control no-cache;
}

# /etc/nginx/conf.d/tomcat-project-name.location.conf
location /PROJECT-URI/ {
    # Proxy headerid kliendi info edastamiseks
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header Host $http_host;

    proxy_pass http://PROJECT-BACKEND:8080/PROJECT-BACKEND-PATH/;

    proxy_set_header Server "Apache/2.4.54 (Unix)";
    proxy_set_header X-Powered-By "IIS/10.0";

    proxy_hide_header X-AspNet-Version;
    proxy_hide_header X-AspNetMvc-Version;
    proxy_hide_header X-Runtime;
    proxy_hide_header X-AspNetCore-Version;

    proxy_pass_header Set-Cookie;

    add_header Cache-Control no-cache;
}

location /micronaut-start-project/ {
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://micronaut-start-project:8080/;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_pass_header Server;
    proxy_pass_header Set-Cookie;
    proxy_set_header Host $http_host;
    add_header Cache-Control no-cache;
}

location /springboot-start-project/ {
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://springboot-start-project:8080/;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_pass_header Server;
    proxy_pass_header Set-Cookie;
    proxy_set_header Host $http_host;
    add_header Cache-Control no-cache;
}

location /node-start-project/ {
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://node-start-project:3000/;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_pass_header Server;
    proxy_pass_header Set-Cookie;
    proxy_set_header Host $http_host;
    add_header Cache-Control no-cache;
}
```
