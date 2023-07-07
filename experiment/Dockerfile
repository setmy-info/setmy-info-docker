FROM setmyinfo/setmy-info-rocky:latest

RUN dnf -y install sudo && \
    echo "microservice ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

ENV PATH=/opt/setmy.info/bin:$PATH

COPY do-install /opt/setmy.info/bin/
COPY do-main-work /opt/setmy.info/bin/

USER microservice

CMD [ "smi-docker-command", "do-install", "do-main-work", "a", "b", "c"]
