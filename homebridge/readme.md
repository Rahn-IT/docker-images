# Homebridge

Image URL: ``ghcr.io/rahn-it/homebridge``

This is a debian based, minimal homebridge image.
The image itself already contains nodejs, homebridge and homebridge-ui.

[You can find the official Homebridge repository here](https://github.com/homebridge/homebridge)

This image was created, because the official image was rolling out with an
older Nodejs version, which wasn't recent for all the needed plugins.
It's meant to be simplistic and easy to debug.

You can use `HOMEBRIDGE_PORT` to change the port homebridge listens on. The default is `8080`.

The Volume `/homebridge` is used to hold your installed plugins and configuration.

Feel free to take a look at the Dockerfile.

⚠️ WARNING ⚠️

The volume structure is not compatible with the official image!
Do not simply exchange the image with this one.

