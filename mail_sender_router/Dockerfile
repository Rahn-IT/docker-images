FROM debian:bookworm

LABEL org.opencontainers.image.source = "https://github.com/Rahn-IT/docker-images/tree/master/mail_sender_router"

RUN apt-get update && \
    apt-get upgrade -y && \
    echo "postfix postfix/mailname string your.hostname.com" | debconf-set-selections && \
    echo "postfix postfix/main_mailer_type string 'Satellite system'" | debconf-set-selections && \
    apt-get install postfix -y && \
    apt-get clean && \
    postconf -e "maillog_file = /dev/stdout" && \
    postconf -e "smtp_sasl_auth_enable = yes" && \
    postconf -e "smtp_sasl_password_maps = hash:/etc/postfix/sasl_password" && \
    postconf -e "smtp_sasl_security_options = noanonymous" && \
    postconf -e "smtp_tls_security_level = encrypt" && \
    postconf -e "smtp_tls_note_starttls_offer = yes"

COPY ./start.sh /start.sh
# COPY ./main.cf /etc/postfix/main.cf

CMD ["bash", "/start.sh"]