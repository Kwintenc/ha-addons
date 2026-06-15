ARG BUILD_FROM=lscr.io/linuxserver/bambustudio:latest
FROM ${BUILD_FROM}

# Install bashio so the run script can read add-on options
ARG BASHIO_VERSION="0.16.2"
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && curl -fsSL \
       "https://github.com/hassio-addons/bashio/archive/refs/tags/v${BASHIO_VERSION}.tar.gz" \
       | tar xz -C /tmp \
    && mv "/tmp/bashio-${BASHIO_VERSION}/lib" /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && rm -rf /tmp/bashio-* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy our entrypoint wrapper
COPY run.sh /ha-run.sh
RUN chmod +x /ha-run.sh

# Add-on label required by HA
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION
LABEL \
    io.hass.name="Bambu Studio" \
    io.hass.description="Bambu Studio slicer running in a browser via linuxserver.io" \
    io.hass.arch="amd64" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}" \
    maintainer="Kwinten"

CMD ["/ha-run.sh"]
