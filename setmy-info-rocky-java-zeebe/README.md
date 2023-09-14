# setmy-info-rocky-java-zeebe

## run for development

docker run --name zeebe -p 26500:26500 setmyinfo/setmy-info-rocky-java-zeebe:latest
zbctl status
wget -c https://docs.zeebe.io/introduction/order-process.bpmn
zbctl deploy order-process.bpmn
zbctl create worker payment-service --handler cat & zbctl create worker inventory-service --handler cat & zbctl create
worker shipment-service --handler cat &
To kill: kill %1 %2 %3
zbctl create instance order-process --variables '{"orderId": 12345}'

## License

Under Zeebe license.
