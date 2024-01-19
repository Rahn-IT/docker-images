FROM eclipse-mosquitto

LABEL org.opencontainers.image.source = "https://github.com/Rahn-IT/docker-images/tree/master/mail_sender_router"

RUN apk add --no-cache bash

ENV PORT=1883

COPY ./start.sh /start.sh

CMD ["bash" , "/start.sh"]