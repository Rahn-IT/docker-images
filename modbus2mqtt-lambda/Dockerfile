FROM swift:latest as builder
WORKDIR /swift
RUN git clone https://github.com/acul009/modbus-2-mqtt-bridge.git /swift
RUN swift build -c release
RUN chmod -R u+rwX,go+rX-w /swift/.build/release/

FROM swift:slim
WORKDIR /modbus2mqtt
ENV PATH="$PATH:/modbus2mqtt" \
    MODBUS_SERVER=lambda \
    MQTT_SERVER=mqtt \
    MQTT_TOPIC=lambda
RUN chmod -R ugo+rwX /modbus2mqtt
COPY --from=builder /swift/.build/release/modbus2mqtt .
COPY --from=builder /swift/.build/release/modbus2mqtt_modbus2mqtt.resources ./modbus2mqtt_modbus2mqtt.resources
COPY start.sh /
CMD ["bash", "-c", "/start.sh"]