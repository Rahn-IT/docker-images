# Homebridge

Image URL: ``ghcr.io/rahn-it/homebridge``

This is a debian based, minimal homebridge image.
The image itself already contains nodejs, homebridge and homebridge-ui.

[You can find the official Homebridge repository here](https://github.com/homebridge/homebridge)

This image was created, because the official image was rolling out with an
older Nodejs version, which wasn't recent for all the needed plugins.
It's meant to be simplistic and easy to debug.

You can use `HOMEBRIDGE_PORT` to change the port homebridge listens on. The default is `8080`.

Feel free to take a look aat the Dockerfile.
