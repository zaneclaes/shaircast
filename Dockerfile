FROM debian:buster-slim
MAINTAINER zane@technicallywizardry.com

# Shairport Sync
RUN apt-get update -y && apt-get install -y \
        build-essential \
        git \
        xmltoman \
        autoconf \
        automake \
        libtool \
        libpopt-dev \
        libconfig-dev \
        libasound2-dev \
        avahi-daemon \
        libavahi-client-dev \
        libssl-dev \
        libsoxr-dev \
        dbus \
        libmosquitto-dev \
        libdaemon-dev \
        libpopt-dev

RUN git clone https://github.com/mikebrady/shairport-sync.git \
        && cd shairport-sync \
        && autoreconf -fi \
        && ./configure --sysconfdir=/etc  \
                --with-alsa \
                --with-pipe \
                --with-avahi \
                --with-ssl=openssl \
                --with-soxr \
                --with-metadata \
                --with-mqtt-client \
                --with-stdout \
        && make \
        && make install

# Snapserver
ARG snapcast_version=0.19.0
ARG TARGETARCH=amd64

RUN  apt-get update \
  && apt-get install -y wget ca-certificates \
  && rm -rf /var/lib/apt/lists/*
RUN  wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapserver_${snapcast_version}-1_$(echo $TARGETARCH | sed 's/arm/armhf/g').deb
RUN  dpkg -i snapserver_${snapcast_version}-1_$(echo $TARGETARCH | sed 's/arm/armhf/g').deb \
  ;  apt-get update \
  && apt-get -f install -y \
  && rm -rf /var/lib/apt/lists/*
RUN /usr/bin/snapserver -v
COPY snapserver.conf /etc/snapserver.conf
COPY index.html /www/index.html
EXPOSE 1704 1705 1780
ENTRYPOINT ["/bin/bash","-c","/usr/bin/snapserver"]

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV AIRPLAY_NAME Airplay

ENTRYPOINT [ "/docker-entrypoint.sh" ]
