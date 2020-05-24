# AirCast
Airplay -> Multi-Room Audio (Snapcast &amp; Shairport Sync in one docker container)

Available in two flavours:

* `inzania/aircast:amd64`
* `inzania/aircast:armhf`

You can mount your own `snapserver` config file at `/etc/snapserver.conf` (see included example file).

It should be as simple as launching this Docker container, connecting a snapclient to the Airplay stream, and then selecting Airplay from your device output.
