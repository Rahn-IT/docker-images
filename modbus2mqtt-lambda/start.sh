#!/bin/bash

exec /modbus2mqtt/modbus2mqtt --modbus-server "$MODBUS_SERVER" --mqtt-servername "$MQTT_SERVER" --topic "$MQTT_TOPIC" --device-description-file lambda.json