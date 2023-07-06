FROM setmyinfo/setmy-info-rocky:latest

RUN dnf -y install sudo && \
    cp /etc/sudoers /etc/sudoers.backup && \
    echo "microservice ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

ENV PATH=/opt/setmy.info/bin:$PATH

COPY do-install /opt/setmy.info/bin/
COPY do-main-work /opt/setmy.info/bin/

USER microservice

CMD [ "smi-docker-command", "/opt/setmy.info/bin/do-install", "/opt/setmy.info/bin/do-main-work", "a", "b", "c"]
