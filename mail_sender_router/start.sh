#!/bin/bash
# https://blog.fhrnet.eu/2017/10/29/postfix-routing-outgoing-email-to-relay-based-on-sender-domain/
counter=1

while [ -n "$(eval echo \$ENV_VAR${counter})" ]; do
  echo "ENV_VAR${counter}: $(eval echo \$ENV_VAR${counter})"
  ((counter++))
done