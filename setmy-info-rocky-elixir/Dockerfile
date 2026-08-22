FROM setmyinfo/setmy-info-rocky:latest AS BUILD

ARG BUILD_DATE
ARG VCS_REF
ARG ERLANG_VERSION=29.0.5
ARG ELIXIR_VERSION=1.20.3
ARG LFE_VERSION=2.2.2

# Install Erlang/OTP build dependencies and compile Erlang.
# glibc-langpack-en is required so the Elixir build does not warn about latin1
# encoding and Elixir itself works correctly with non-ASCII source.
RUN source /etc/profile.d/setmy-info.sh && \
    dnf -y install git gcc gcc-c++ make autoconf ncurses-devel openssl-devel sudo glibc-langpack-en && \
    smi-download-package erlang && \
    smi-install-package erlang && \
    dnf clean all && rm -rf /var/cache/dnf

# Elixir compilation needs Erlang on PATH, and the locale must be UTF-8
# before mix/elixirc runs or it emits latin1 warnings and may misbehave.
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV ELIXIR_ERL_OPTIONS="+fnu"
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
ARG ERLANG_VERSION=29.0.5
ARG ELIXIR_VERSION=1.20.3
ARG LFE_VERSION=2.2.2
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
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-elixir" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-elixir" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

# Erlang embeds the install prefix in its shell scripts (ROOTDIR=...).
# Copying the versioned directory preserves that path so erlexec is found.
# A symlink is then created so ENV ERLANG_HOME=/opt/erlang works as expected.
# Elixir and LFE scripts resolve their location relatively so the same
# versioned-dir + symlink approach is used for consistency.
RUN dnf -y install glibc-langpack-en && dnf clean all && rm -rf /var/cache/dnf

COPY --from=BUILD /opt/erlang-${ERLANG_VERSION} /opt/erlang-${ERLANG_VERSION}
COPY --from=BUILD /opt/elixir-${ELIXIR_VERSION} /opt/elixir-${ELIXIR_VERSION}
COPY --from=BUILD /opt/lfe-${LFE_VERSION}       /opt/lfe-${LFE_VERSION}

RUN ln -sf /opt/erlang-${ERLANG_VERSION} /opt/erlang && \
    ln -sf /opt/elixir-${ELIXIR_VERSION} /opt/elixir && \
    ln -sf /opt/lfe-${LFE_VERSION}       /opt/lfe && \
    chown -R root:root /opt/erlang-${ERLANG_VERSION} \
                       /opt/elixir-${ELIXIR_VERSION} \
                       /opt/lfe-${LFE_VERSION} && \
    chmod ugo+rx  /opt/erlang/bin/* && \
    chmod ugo+rx  /opt/elixir/bin/* && \
    chmod -R ugo+rX /opt/lfe

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV ELIXIR_ERL_OPTIONS="+fnu"
ENV ERLANG_HOME=/opt/erlang
ENV ELIXIR_HOME=/opt/elixir
ENV LFE_HOME=/opt/lfe
ENV PATH="${LFE_HOME}/bin:${ELIXIR_HOME}/bin:${ERLANG_HOME}/bin:${PATH}"

RUN source /etc/profile.d/setmy-info.sh && \
    erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell && \
    elixir --version && \
    ls -la /opt/lfe/bin
