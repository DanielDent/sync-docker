FROM danieldent/debian-base
MAINTAINER Daniel Dent (https://www.danieldent.com/)
LABEL com.getsync.version="2.3.8"

ADD https://download-cdn.getsync.com/2.3.8/linux-x64/BitTorrent-Sync_x64.tar.gz /tmp/sync.tgz
RUN echo -n "9e1a63d7e346278f7301f149626013242a3c605db90a645ebe757c164cd1c50a  /tmp/sync.tgz" | sha256sum -c \
    && tar -xzf /tmp/sync.tgz -C /usr/sbin btsync \
    && rm -f /tmp/sync.tgz

COPY btsync.conf /etc/
COPY run_sync /opt/

EXPOSE 8888
EXPOSE 55555

VOLUME /mnt/sync

ENTRYPOINT ["/opt/run_sync"]
CMD ["--log", "--config", "/etc/btsync.conf"]
