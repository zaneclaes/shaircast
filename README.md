# ShairCast
Airplay -> Multi-Room Audio (`shairport-sync` -> `snapserver` in one docker container)

Available in two flavours:

* `inzania/shaircast:amd64`
* `inzania/shaircast:armhf`

You can mount your own `snapserver` config file at `/etc/snapserver.conf` (see included example file).

It should be as simple as launching this Docker container, connecting a snapclient to the Airplay stream, and then selecting Airplay from your device output.
