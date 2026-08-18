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

## Controller or node

The same image is started as a Jenkins controller or as a Jenkins agent node. The container entry point **do-start**
selects the role and calls **smi-jenkins-controller** or **smi-jenkins-node**, which detect the live installation from
the effective user (**jenkins**) themselves.

| Variable                      | Role       | Meaning                                | Default                                                         |
|-------------------------------|------------|----------------------------------------|-----------------------------------------------------------------|
| `SMI_JENKINS_ROLE`            | both       | `controller` or `node`                 | `node` when `SMI_JENKINS_SECRET` is set, otherwise `controller` |
| `SMI_JENKINS_HOST`            | controller | Listen address                         | `0.0.0.0`                                                       |
| `SMI_JENKINS_PORT`            | controller | HTTP port                              | `7070`                                                          |
| `SMI_JENKINS_HOME`            | controller | Jenkins home                           | `/var/lib/jenkins`                                              |
| `SMI_JENKINS_CONTROLLER_HOST` | node       | Controller host                        | `127.0.0.1`                                                     |
| `SMI_JENKINS_CONTROLLER_PORT` | node       | Controller port                        | `7070`                                                          |
| `SMI_JENKINS_NODE_NAME`       | node       | Node name as created on the controller | Container host name                                             |
| `SMI_JENKINS_WORKDIR`         | node       | Agent work directory                   | `/var/lib/jenkins/nodes/NAME`                                   |
| `SMI_JENKINS_SECRET`          | node       | Agent secret, **required**             | None                                                            |
| `JAVA_OPTS`                   | both       | Additional JVM options                 | None                                                            |

The agent secret is never given on the command line. Use `--env-file` with Docker and a **Secret** with Kubernetes.

Controller:

```shell
docker run --name jenkins-controller -p 7070:7070 -d setmyinfo/setmy-info-rocky-java-jenkins:latest
```

Node, secret in a file that is not committed:

```shell
echo "SMI_JENKINS_SECRET=THE-SECRET-OF-THE-NODE" > jenkins-node.env
docker run --name jenkins-node-1 \
    --env-file jenkins-node.env \
    -e SMI_JENKINS_ROLE=node \
    -e SMI_JENKINS_CONTROLLER_HOST=jenkins-controller \
    -e SMI_JENKINS_CONTROLLER_PORT=7070 \
    -e SMI_JENKINS_NODE_NAME=docker-node-1 \
    -d setmyinfo/setmy-info-rocky-java-jenkins:latest
```

The node connects out to the controller over a web socket, so it needs no published port.

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

The agent nodes are deployed after the controller is running and the node is created in the controller user interface.
The node name in **jenkins-config-map** and the secret in **jenkins-secrets-map** must be the ones of that node.

```shell
kubectl apply -f src/main/k8s/dev/jenkins-node-deployment.yaml
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
kubectl delete deployment jenkins-node-deployment
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
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-java-jenkins:2.568.2-4 -t setmyinfo/setmy-info-rocky-java-jenkins:latest .
docker run --rm -p 30000:7070 setmyinfo/setmy-info-rocky-java-jenkins:latest
docker exec -it HASH /bin/sh
java -jar /opt/setmy.info/lib/jenkins-cli.jar -s http://localhost:7070/ help
java -jar /opt/setmy.info/lib/jenkins-cli.jar -s http://localhost:7070/ -auth user:user list-plugins
java -jar /opt/setmy.info/lib/jenkins-cli.jar -s http://localhost:7070/ -auth user:user install-plugin workflow-aggregator email-ext github ssh-credentials publish-over-ssh ant blueocean blueocean-pipeline-editor blueocean-git-pipeline blueocean-github-pipeline blueocean-dashboard blueocean-i18n blueocean-events blueocean-web -restart

docker run --name setmy-info-rocky-java-jenkins -p 30000:7070 -v /var/opt/setmy.info/gintra:/mnt/gintra -d setmyinfo/setmy-info-rocky-java-jenkins:latest
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
