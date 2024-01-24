#!/bin/bash
# https://blog.fhrnet.eu/2017/10/29/postfix-routing-outgoing-email-to-relay-based-on-sender-domain/

echo "##### CONFIGURING POSTFIX #####"

relays="#Generated by start.sh\n"
counter=1

while [ -n "$(eval echo \$EMAIL_${counter})" ]; do
  echo "Relaying from $(eval echo \$EMAIL_${counter}) via $(eval echo \$SERVER_${counter})"
  relays+="$(eval echo \$EMAIL_${counter})    $(eval echo \$SERVER_${counter})\n"
  ((counter++))
done

credentials="#Generated by start.sh\n"
counter=1

if [ -n "$SERVER_1" ]; then
  postconf -e "relayhost = $SERVER_1"
fi

while [ -n "$(eval echo \$EMAIL_${counter})" ]; do
  credentials+="$(eval echo \$SERVER_${counter})    $(eval echo \$CREDENTIALS_${counter})\n"
  ((counter++))
done


printf "$relays" > /etc/postfix/relay_maps
postmap /etc/postfix/relay_maps

printf "$credentials" > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd

echo "setting allowed networks to $TRUSTED_NETWORKS"
postconf -e "mynetworks = $TRUSTED_NETWORKS"

echo deleting old resolv.conf
rm /var/spool/postfix/etc/resolv.conf
echo creating new resolv.conf
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

if [ -n "$TLS_ONLY" ]; then
  echo "TLS_ONLY is set, forcing TLS"
  postconf -e "smtpd_tls_security_level = encrypt"
else
  echo "TLS_ONLY is not set, TLS is optional"
  postconf -e "smtpd_tls_security_level = may"
fi

echo "configuration done"

if [ ! -f /etc/ssl/store/certs/cert.pem ]; then
  echo "##### GENERATING NEW SSL CERTIFICATE #####"
  hostname=$(hostname)
  mkdir /tmp/ssl
  # generate rsa key of ca
  openssl req -x509 -newkey rsa:4096 -keyout /tmp/ssl/key.pem -out /tmp/ssl/cert.pem -sha256 -days 3650 -noenc -subj "/C=DE/ST=Bayern/L=Tuessling/O=Rahn-IT/OU=IT/CN=$hostname"
  
  
  mkdir -p /etc/ssl/store/private /etc/ssl/store/certs
  mv /tmp/ssl/key.pem /etc/ssl/store/private/key.pem
  mv /tmp/ssl/cert.pem /etc/ssl/store/certs/cert.pem
  rm -r /tmp/ssl
fi

echo "##### CURRENT SSL CERTIFICATE #####"
cat /etc/ssl/store/certs/cert.pem

echo "##### STARTING POSTFIX #####"


exec postfix start-fg

echo 