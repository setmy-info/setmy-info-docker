ARG ERLANG_VERSION=29.1.2
ARG ELIXIR_VERSION=1.20.5
ARG VERSION=${ELIXIR_VERSION}
#ARG VERSION=${ELIXIR_VERSION}-0
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS ERLANG_BUILD

ARG ERLANG_VERSION

ENV LANG=en_US.UTF-8

RUN source /etc/profile.d/setmy-info.sh && \
    dnf -y install git gcc gcc-c++ make autoconf perl ncurses-devel openssl-devel sudo glibc-langpack-en && \
    mkdir -p $(smi-home-packages-location) && \
    echo "ERLANG_VERSION=${ERLANG_VERSION}" > $(smi-home-packages-location)/erlang.package && \
    smi-download-package erlang && \
    smi-build-package erlang && \
    smi-install-package erlang && \
    ls -la /opt && \
    /opt/erlang-${ERLANG_VERSION}/bin/erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell

FROM ERLANG_BUILD AS ELIXIR_BUILD

ARG ELIXIR_VERSION

ENV ELIXIR_ERL_OPTIONS="+fnu"
ENV PATH="/opt/erlang/bin:${PATH}"

RUN source /etc/profile.d/setmy-info.sh && \
    echo "ELIXIR_VERSION=${ELIXIR_VERSION}" > $(smi-home-packages-location)/elixir.package && \
    smi-download-package elixir && \
    smi-build-package elixir && \
    smi-install-package elixir && \
    rm -rf /opt/elixir-${ELIXIR_VERSION}/.git && \
    ls -la /opt && \
    /opt/elixir-${ELIXIR_VERSION}/bin/elixir --version

FROM setmyinfo/setmy-info-rocky:latest

ARG ERLANG_VERSION
ARG ELIXIR_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Elixir" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux with Erlang and Elixir" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="Apache-2.0,MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/README.md" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-elixir" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-elixir" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

RUN dnf -y install glibc-langpack-en ncurses-libs openssl-libs && \
    dnf clean all && rm -rf /var/cache/dnf

COPY --from=ERLANG_BUILD /opt/erlang-${ERLANG_VERSION} /opt/erlang-${ERLANG_VERSION}
COPY --from=ELIXIR_BUILD /opt/elixir-${ELIXIR_VERSION} /opt/elixir-${ELIXIR_VERSION}
RUN ln -sf /opt/erlang-${ERLANG_VERSION} /opt/erlang && \
    ln -sf /opt/elixir-${ELIXIR_VERSION} /opt/elixir && \
    chown -R root:root /opt/erlang-${ERLANG_VERSION} \
                       /opt/elixir-${ELIXIR_VERSION} && \
    chmod ugo+rx /opt/erlang/bin/* && \
    chmod ugo+rx /opt/elixir/bin/*
ENV LANG=en_US.UTF-8
ENV ELIXIR_ERL_OPTIONS="+fnu"
ENV ERLANG_HOME=/opt/erlang
ENV ELIXIR_HOME=/opt/elixir
ENV PATH="${ELIXIR_HOME}/bin:${ERLANG_HOME}/bin:${PATH}"
RUN erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell && \
    elixir --version
