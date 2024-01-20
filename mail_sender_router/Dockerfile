FROM debian:bookworm

LABEL org.opencontainers.image.source = "https://github.com/Rahn-IT/docker-images/tree/master/mail_sender_router"

RUN apt-get update && \
    apt-get upgrade -y && \
    echo "postfix postfix/mailname string your.hostname.com" | debconf-set-selections && \
    echo "postfix postfix/main_mailer_type string 'Satellite system'" | debconf-set-selections && \
    apt-get install postfix -y && \
    apt-get clean && \
    mkdir -p /etc/ssl/store/certs /etc/ssl/store/private && \
    postconf -e "sender_dependent_relayhost_maps = hash:/etc/postfix/relay_maps" && \
    postconf -e "maillog_file = /dev/stdout" && \
    postconf -e "smtp_sasl_auth_enable = yes" && \
    postconf -e "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd" && \
    postconf -e "smtp_sasl_security_options = noanonymous" && \
    postconf -e "smtp_tls_security_level = encrypt" && \
    postconf -e "smtp_tls_note_starttls_offer = yes" && \
    postconf -e 'smtpd_tls_auth_only = no' && \
    postconf -e 'smtp_use_tls = yes' && \
    postconf -e 'smtpd_use_tls = yes' && \
    postconf -e 'smtp_tls_note_starttls_offer = yes' && \
    postconf -e 'smtpd_tls_key_file = /etc/ssl/store/private/key.pem' && \
    postconf -e 'smtpd_tls_cert_file = /etc/ssl/store/certs/cert.pem' && \
    postconf -e 'smtpd_tls_CAfile = /etc/ssl/store/certs/cert.pem' && \
    postconf -e 'smtpd_tls_loglevel = 1' && \
    postconf -e 'smtpd_tls_received_header = yes' && \
    postconf -e 'smtpd_tls_session_cache_timeout = 3600s' && \
    postconf -e 'tls_random_source = dev:/dev/urandom' && \
    postconf -e 'smtp_tls_wrappermode = yes' && \
    postconf -e 'smtp_tls_security_level = encrypt'

ENV TRUSTED_NETWORKS="127.0.0.0/8"
ENV TLS_ONLY=true

VOLUME /etc/ssl/store

EXPOSE 25

COPY ./start.sh /start.sh
# COPY ./main.cf /etc/postfix/main.cf

CMD ["bash", "/start.sh"]