# Readme

location /tomcat-start-project/ {
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://tomcat-start-project:8080/tomcat-start-project-1.2.0-SNAPSHOT/;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_pass_header Server;
    proxy_pass_header Set-Cookie;
    proxy_set_header Host $http_host;
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
