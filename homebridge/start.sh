#!/bin/sh  

cd /homebridge

# if [ ! -f package.json ]; then
#     echo '{"dependencies": {}}' > /homebridge/package.json
# fi

if [ ! -d node_modules ]; then
    mkdir /homebridge/node_modules
fi

npx hb-service run -K --port $HOMEBRIDGE_PORT --user homebridge -U /homebridge/ -P /homebridge/node_modules/