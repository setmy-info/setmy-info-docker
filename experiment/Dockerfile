FROM setmyinfo/setmy-info-rocky:latest

RUN dnf -y install sudo && \
    cp /etc/sudoers /etc/sudoers.backup && \
    echo "microservice ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

ENV PATH=/opt/setmy.info/bin:$PATH

COPY smi-docker-command /opt/setmy.info/bin/
COPY smi-root-once /opt/setmy.info/bin/

COPY do-install /opt/setmy.info/bin/
COPY do-main-work /opt/setmy.info/bin/

USER microservice

CMD [ "smi-docker-command", "do-install", "do-main-work", "a", "b", "c"]
