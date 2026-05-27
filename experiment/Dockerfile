FROM setmyinfo/setmy-info-rocky:latest

RUN dnf -y install sudo && \
    echo "microservice ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

COPY do-install /opt/setmy.info/bin/
COPY do-main-work /opt/setmy.info/bin/
COPY requirements.txt /var/opt/setmy.info/microservice
COPY requirements-ai.txt /var/opt/setmy.info/microservice
COPY project /var/opt/setmy.info/microservice
COPY hello.py /var/opt/setmy.info/microservice

USER microservice

WORKDIR /var/opt/setmy.info/microservice

CMD [ "smi-docker-command", "do-install", "do-main-work", "a", "b", "c"]
#CMD [ "smi-docker-command", "do-install", "smi-python", "hello.py"]
