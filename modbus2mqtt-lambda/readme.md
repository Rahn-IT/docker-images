# modbus2mqtt for lamda heatpumps

image-name: `ghcr.io/rahn-it/modbus2mqtt-lambda`

This packes a version of modbus2mqtt by jollyjinx found [here](https://github.com/jollyjinx/modbus-2-mqtt-bridge).

With a small fix applied [here](https://github.com/acul009/modbus-2-mqtt-bridge).

The image has the following options:

| Enironment Variable | Effect                                                  |
|---------------------|---------------------------------------------------------|
| `MODBUS_SERVER`     | Set this to the ip of your heatpump                     |
| `MQTT_SERVER`       | Set this to the ip or hostname of your MQTT server      |
| `MQTT_TOPIC`        | Here you can change the MQTT-Tpoic. default is `lambda` |