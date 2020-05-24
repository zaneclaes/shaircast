#!/bin/sh

rm -rf /var/run
mkdir -p /var/run/dbus
mkdir -p /run/dbus/

dbus-uuidgen --ensure
dbus-daemon --system

avahi-daemon --daemonize --no-chroot

snapserver
