# setmy-info-rocky-java-jenkins

Currently, only for internal network, in-house, by team use. Security related enhancements still waiting to be done.

## Installed

* Installed suggested plugins.
* Installed:
    * Blue Ocean/blueocean : https://plugins.jenkins.io/blueocean/
    * JavaMail API/javax-mail-api : https://plugins.jenkins.io/javax-mail-api/
    * xxx/xxx : xxx
    * xxx/xxx : xxx
    * xxx/xxx : xxx
    * xxx/xxx : xxx
    * xxx/xxx : xxx
    * xxx/xxx : xxx
    * xxx/xxx : xxx
    * xxx/xxx : xxx
    * xxx/xxx : xxx
    * xxx/xxx : xxx
    * xxx/xxx : xxx
    * xxx/xxx : xxx

## DEV environment setup and config

```shell
kubectl apply -f src/main/k8s/dev/jenkins-namespace.yaml
kubectl apply -f src/main/k8s/dev/jenkins-config-map.yaml
kubectl apply -f src/main/k8s/dev/jenkins-secrets-map.yaml
kubectl apply -f src/main/k8s/dev/jenkins-nfs-persistent-volume.yaml
kubectl apply -f src/main/k8s/dev/jenkins-nfs-persistent-volume-claim.yaml
kubectl apply -f src/main/k8s/dev/jenkins-deployment.yaml
kubectl apply -f src/main/k8s/dev/jenkins-service.yaml
kubectl apply -f src/main/k8s/dev/jenkins-ingress.yaml
```

Change **kubectl** default namespace used. Otherwise, use **-n jenkins-dev** at the end of kubectl command line.

```shell
kubectl config set-context --current --namespace=jenkins-dev
```

Check configuration

```shell
kubectl get namespace
kubectl get pods
kubectl describe configmaps jenkins-config-map
kubectl describe secrets jenkins-secrets-map
kubectl describe pod jenkins-deployment-596744778-dcgtz
```

Delete deployment, but started a new POD to maintain the desired number of replicas defined by **spec.replicas**.

```shell
kubectl delete pod jenkins-deployment-596744778-dcgtz
```

Get ...

```shell
kubectl get endpoints
kubectl get service
```

Remove service and deployment

```shell
kubectl delete deployment jenkins-deployment
```

Remove all

```shell
kubectl delete service jenkins-service
kubectl delete deployment jenkins-deployment
kubectl delete pvc jenkins-nfs-persistent-volume-claim
kubectl delete pv jenkins-nfs-persistent-volume
kubectl delete secrets jenkins-secrets-map
kubectl delete configmap jenkins-config-map
kubectl delete namespace jenkins-ingress
kubectl delete namespace jenkins-dev
```

Because secrets and config maps have **immutable: true**, then config and secret maps need to be removed to apply new
values.

Config map update.

```shell
kubectl delete configmap jenkins-config-map
kubectl apply -f src/main/k8s/dev/jenkins-config-map.yaml
```

Secrets map update.

```shell
kubectl delete secrets jenkins-secrets-map
kubectl apply -f src/main/k8s/dev/jenkins-secrets-map.yaml
```

For probing

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-java-jenkins:2.528.3-1 -t setmyinfo/setmy-info-rocky-java-jenkins:latest .
docker run --rm -p 30000:8080 setmyinfo/setmy-info-rocky-java-jenkins:latest
docker exec -it HASH /bin/sh
java -jar /opt/setmy.info/lib/jenkins-cli.jar -s http://localhost:8080/ help
java -jar /opt/setmy.info/lib/jenkins-cli.jar -s http://localhost:8080/ -auth user:user list-plugins
java -jar /opt/setmy.info/lib/jenkins-cli.jar -s http://localhost:8080/ -auth user:user install-plugin workflow-aggregator email-ext github ssh-credentials publish-over-ssh ant blueocean blueocean-pipeline-editor blueocean-git-pipeline blueocean-github-pipeline blueocean-dashboard blueocean-i18n blueocean-events blueocean-web -restart

docker run --name setmy-info-rocky-java-jenkins -p 30000:8080 -v /var/opt/setmy.info/gintra:/mnt/gintra -d setmyinfo/setmy-info-rocky-java-jenkins:latest
```

Packaging installed Jenkins folder

```shell
docker exec -it HASH /bin/sh
mkdir /tmp/packaging
cd /var/lib
tar -czf /tmp/packaging/jenkins-2.0.0.tar.gz jenkins
tar -tzvf /tmp/packaging/jenkins-2.0.0.tar.gz
rm -f /home/has/.setmy.info/packages/jenkins-2.0.0.tar.gz

docker cp HASH:/tmp/packaging/jenkins-2.0.0.tar.gz /home/has/.setmy.info/packages/jenkins-2.0.0.tar.gz
```
