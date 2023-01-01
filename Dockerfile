FROM busybox:1.23
LABEL maintainer="waterlemons2k <docker@waterlemons2k.com>"
ENV DISABLE=0

COPY . /data/
RUN cd /data &&\
    echo "CST-8" > /etc/TZ &&\
    mkdir -p /var/spool/cron/crontabs &&\
    echo -e "45 3 * * * /data/entrypoint.sh > /data/log 2>&1\n" > /var/spool/cron/crontabs/root

VOLUME /mnt/data/ttnode
ENTRYPOINT ["/data/entrypoint.sh"]
CMD ["sh"]
