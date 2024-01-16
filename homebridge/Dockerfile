FROM node:20-bookworm

LABEL org.opencontainers.image.source = "https://github.com/Rahn-IT/docker-images/homebridge"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo && \
    mkdir -p /homebridge && \
    adduser --disabled-password --gecos "" homebridge && \
    chown -R homebridge:homebridge /homebridge && \
    echo "homebridge    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    npm install -g homebridge homebridge-config-ui-x

COPY ./start.sh /start.sh

WORKDIR /homebridge
USER homebridge

ENV UIX_STRICT_PLUGIN_RESOLUTION=0 \
    HOMEBRIDGE_PORT=8080
VOLUME /homebridge
EXPOSE 8080

CMD ["sh", "/start.sh"]