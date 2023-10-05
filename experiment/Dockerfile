FROM setmyinfo/setmy-info-rocky:latest

RUN dnf -y install sudo python3 && \
    echo "microservice ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

#ENV PATH=/opt/setmy.info/bin:$PATH

COPY do-install /opt/setmy.info/bin/
COPY do-main-work /opt/setmy.info/bin/
COPY requirements.txt /var/opt/setmy.info
COPY requirements-ai.txt /var/opt/setmy.info
COPY project /var/opt/setmy.info
COPY hello.py /var/opt/setmy.info

USER microservice

WORKDIR /var/opt/setmy.info

#CMD [ "smi-docker-command", "do-install", "do-main-work", "a", "b", "c"]
CMD [ "smi-docker-command", "do-install", "smi-python", "hello.py"]
