FROM setmyinfo/setmy-info-rocky:latest AS BUILD

ARG BUILD_DATE
ARG VCS_REF

# Build-time hints; actual versions are resolved dynamically by the package scripts.
ARG ERLANG_VERSION=29.0.5
ARG ELIXIR_VERSION=1.20.3
ARG LFE_VERSION=2.2.2

# Install Erlang/OTP build dependencies, then download and compile Erlang.
# Erlang must be on PATH before Elixir and LFE are installed.
RUN source /etc/profile.d/setmy-info.sh && \
    dnf -y install git gcc gcc-c++ make autoconf ncurses-devel openssl-devel sudo && \
    smi-download-package erlang && \
    smi-install-package erlang && \
    dnf clean all && rm -rf /var/cache/dnf

ENV PATH="/opt/erlang/bin:${PATH}"

RUN source /etc/profile.d/setmy-info.sh && \
    smi-download-package elixir && \
    smi-install-package elixir && \
    smi-download-package lfe && \
    smi-install-package lfe

# ─────────────────────────────────────────────────────────────────────────────

FROM setmyinfo/setmy-info-rocky:latest

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=1-1

LABEL org.opencontainers.image.title="Docker HUB Rocky Elixir" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux with Erlang, Elixir and LFE" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="Apache-2.0,MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/README.md" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-elixir" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-elixir" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

# Copy the resolved installations by following the /opt/erlang, /opt/elixir,
# /opt/lfe symlinks that makeOptLink created in the BUILD stage.
# Docker follows symlinks on COPY, so the content lands as real directories.
COPY --from=BUILD /opt/erlang/ /opt/erlang/
COPY --from=BUILD /opt/elixir/ /opt/elixir/
COPY --from=BUILD /opt/lfe/    /opt/lfe/

RUN chown -R root:root /opt/erlang /opt/elixir /opt/lfe && \
    chmod ugo+rx  /opt/erlang/bin/* && \
    chmod ugo+rx  /opt/elixir/bin/* && \
    chmod -R ugo+rX /opt/lfe

ENV ERLANG_HOME=/opt/erlang
ENV ELIXIR_HOME=/opt/elixir
ENV LFE_HOME=/opt/lfe
ENV PATH="${LFE_HOME}/bin:${ELIXIR_HOME}/bin:${ERLANG_HOME}/bin:${PATH}"

RUN source /etc/profile.d/setmy-info.sh && \
    erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell && \
    elixir --version && \
    ls -la /opt/lfe/bin
