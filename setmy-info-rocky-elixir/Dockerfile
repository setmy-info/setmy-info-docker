ARG ERLANG_VERSION
ARG ELIXIR_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS erlang_build

ARG ERLANG_VERSION

ENV LANG=en_US.UTF-8

RUN source /etc/profile.d/setmy-info.sh && \
    dnf -y install git gcc gcc-c++ make autoconf perl ncurses-devel openssl-devel sudo glibc-langpack-en && \
    mkdir -p $(smi-home-packages-location) && \
    smi-download-package erlang && \
    smi-build-package erlang && \
    smi-install-package erlang && \
    ls -la /opt && \
    test -d /opt/erlang-${ERLANG_VERSION} && \
    /opt/erlang/bin/erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell && \
    mkdir -p /dist && \
    cp -a /opt/erlang /opt/erlang-* /dist/

FROM setmyinfo/setmy-info-rocky:latest AS elixir_build

ARG ELIXIR_VERSION

ENV LANG=en_US.UTF-8
ENV ELIXIR_ERL_OPTIONS="+fnu"
ENV PATH="/opt/erlang/bin:${PATH}"

COPY --from=erlang_build /dist/ /opt/

RUN source /etc/profile.d/setmy-info.sh && \
    dnf -y install git make sudo glibc-langpack-en ncurses-libs openssl-libs && \
    mkdir -p $(smi-home-packages-location) && \
    smi-download-package elixir && \
    smi-build-package elixir && \
    smi-install-package elixir && \
    rm -rf /opt/elixir/.git && \
    ls -la /opt && \
    test -d /opt/elixir-${ELIXIR_VERSION} && \
    /opt/elixir/bin/elixir --version && \
    mkdir -p /dist && \
    cp -a /opt/elixir /opt/elixir-* /dist/

FROM setmyinfo/setmy-info-rocky:latest

ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="Docker HUB Rocky Elixir" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux with Erlang and Elixir" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="Apache-2.0,MIT" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy-info-docker/blob/master/README.md" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-elixir" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-elixir" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

RUN dnf -y install glibc-langpack-en ncurses-libs openssl-libs && \
    dnf clean all && rm -rf /var/cache/dnf

COPY --from=erlang_build /dist/ /opt/
COPY --from=elixir_build /dist/ /opt/
RUN chown -R -H root:root /opt/erlang /opt/elixir && \
    chmod ugo+rx /opt/erlang/bin/* && \
    chmod ugo+rx /opt/elixir/bin/*
ENV LANG=en_US.UTF-8
ENV ELIXIR_ERL_OPTIONS="+fnu"
ENV ERLANG_HOME=/opt/erlang
ENV ELIXIR_HOME=/opt/elixir
ENV PATH="${ELIXIR_HOME}/bin:${ERLANG_HOME}/bin:${PATH}"
RUN erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell && \
    elixir --version
