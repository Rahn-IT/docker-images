# Mosquitto

image: ``ghcr.io/rahn-it/mosquitto``

This image is based on the official "eclipse-mosquitto" image.
It just adds a small start script which creates the config.

| Environment Variable | Effect                                 |
|----------------------|----------------------------------------|
| ``PORT``             | Selects the Port to listen on          |
| ``USER``             | (Optional) sets the username for login |
| ``PASSWORD``         | (Optional) sets the password for login |