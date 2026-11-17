# setmy-info-rocky-java-zeebe

## Build

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-java-zeebe:8.10.9 -t setmyinfo/setmy-info-rocky-java-zeebe:latest .
```

## Execute

```shell
docker run --rm -p 26500:26500 -p 8080:8080 setmyinfo/setmy-info-rocky-java-zeebe:latest
docker run --rm -it -p 26500:26500 -p 26501:26501 -p 26502:26502 -p 8080:8080 -p 9600:9600 setmyinfo/setmy-info-rocky-java-zeebe:latest
docker run --rm -p 26500:26500 -p 8080:8080 -e CAMUNDA_DATA_SECONDARYSTORAGE_TYPE=elasticsearch -e CAMUNDA_DATA_SECONDARYSTORAGE_ELASTICSEARCH_URL=http://elasticsearch:9200 setmyinfo/setmy-info-rocky-java-zeebe:latest
```

Gateway gRPC port **26500**, command API port **26501**, internal cluster port **26502**, REST API port **8080**,
management port **9600**, health URL `http://localhost:9600/actuator/health`.

Standalone broker runs without secondary storage (**CAMUNDA_DATA_SECONDARYSTORAGE_TYPE=none**), API is unprotected and
authorizations are disabled. All of these can be overridden with environment variables.

## run for development

docker run --name zeebe -p 26500:26500 setmyinfo/setmy-info-rocky-java-zeebe:latest
zbctl status
wget -c https://docs.zeebe.io/introduction/order-process.bpmn
zbctl deploy order-process.bpmn
zbctl create worker payment-service --handler cat & zbctl create worker inventory-service --handler cat & zbctl create
worker shipment-service --handler cat &
To kill: kill %1 %2 %3
zbctl create instance order-process --variables '{"orderId": 12345}'

    docker run --rm -it -p 26500:26500 -p 26501:26501 -p 26502:26502 setmyinfo/setmy-info-rocky-java-zeebe:latest

## License

Under Zeebe license.
