FROM busybox:1.23
LABEL maintainer="waterlemons2k <waterlemons2k@gmail.com>"
ENV DISABLE=0

RUN echo "CST-8" > /etc/TZ &&\
    mkdir -p /var/spool/cron/crontabs &&\
    echo -e "10 9 * * * /data/entrypoint.sh > /data/log 2>&1\n" > /var/spool/cron/crontabs/root
COPY . /data/

VOLUME /mnt/data/ttnode
ENTRYPOINT ["/data/entrypoint.sh"]
CMD ["sh"]
