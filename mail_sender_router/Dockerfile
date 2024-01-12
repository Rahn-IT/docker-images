FROM node:20-bookworm

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install posfix -y

COPY ./start.sh /start.sh
COPY ./main.cf /etc/postfix/main.cf

CMD ["sh", "/start.sh"]