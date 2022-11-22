FROM alpine:2.6
LABEL maintainer="waterlemons2k <waterlemons2k@gmail.com>"
ENV DISABLE=0

RUN echo "CST-8" > /etc/TZ &&\
    echo -e "10 9 * * * /data/entrypoint.sh > /data/log 2>&1\n" > /var/spool/cron/crontabs/root
COPY . /data/

VOLUME /mnt/data/ttnode
ENTRYPOINT ["/data/entrypoint.sh"]
