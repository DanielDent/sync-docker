# BitTorrent Sync
#
# VERSION               0.1

FROM ubuntu:15.04
MAINTAINER Bertrand Chazot <bertrand@bittorrent.com>
LABEL com.getsync.version="2.3.3"

ADD https://download-cdn.getsync.com/2.3.3/linux-x64/BitTorrent-Sync_x64.tar.gz /tmp/sync.tgz
RUN echo -n "961c87c1bb3a166c85bb3254b1c2ac477167dc8271be92321b71c4d3bc13df50  /tmp/sync.tgz" | sha256sum -c \
    && tar -xzf /tmp/sync.tgz -C /usr/sbin btsync \
    && rm -f /tmp/sync.tgz

COPY btsync.conf /etc/
COPY run_sync /opt/

EXPOSE 8888
EXPOSE 55555

VOLUME /mnt/sync

ENTRYPOINT ["/opt/run_sync"]
CMD ["--log", "--config", "/etc/btsync.conf"]
