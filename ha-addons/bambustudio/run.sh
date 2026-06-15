#!/usr/bin/env bashio

# ---------------------------------------------------------------------------
# Bambu Studio – Home Assistant add-on run script
# Translates add-on options into environment variables for the container.
# ---------------------------------------------------------------------------

DARK_MODE=$(bashio::config 'dark_mode')
PASSWORD=$(bashio::config 'password')

# Export env vars picked up by s6 / the linuxserver image
export DARK_MODE="${DARK_MODE}"
export TZ="${TZ:-Europe/Brussels}"
export PUID="1000"
export PGID="1000"

# Optional HTTP Basic Auth
if bashio::var.has_value "${PASSWORD}"; then
    export CUSTOM_USER="admin"
    export PASSWORD="${PASSWORD}"
    bashio::log.info "HTTP Basic Auth is ENABLED (user: admin)"
else
    bashio::log.info "HTTP Basic Auth is DISABLED – accessible to anyone on your local network"
fi

# Ingress: the HA supervisor handles HTTPS termination.
# Inside the container we use HTTP port 3000.
# HTTPS port 3001 is used by the ingress stream.
export CUSTOM_PORT="3000"
export CUSTOM_HTTPS_PORT="3001"

bashio::log.info "Starting Bambu Studio …"
exec /init
