FROM node:20-bookworm

RUN apt-get update && \
    apt-get upgrade -y && \
    echo "postfix postfix/mailname string your.hostname.com" | debconf-set-selections && \
    echo "postfix postfix/main_mailer_type string 'Satellite system'" | debconf-set-selections && \
    apt-get install postfix -y

COPY ./start.sh /start.sh
# COPY ./main.cf /etc/postfix/main.cf

CMD ["bash", "/start.sh"]