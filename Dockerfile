FROM debian:buster-slim
LABEL maintainer="waterlemons2k <waterlemons2k@gmail.com>"

COPY ["entrypoint.sh", "localtime", "signin", "token", "ttnode", "yfapp.conf", "/data/"]
RUN cd /data &&\
    chmod +x entrypoint.sh signin token ttnode &&\
    mv localtime /etc &&\
    apt-get update && apt-get install --no-install-recommends -y cron procps && apt-get clean &&\
    rm -rf /var/cache/* /var/lib/apt/lists/* &&\
    echo "10 9 * * * /data/signin > /data/signin.log 2>&1" > /etc/cron.d/crontab && crontab /etc/cron.d/crontab

ENV DISABLE=0
VOLUME /mnt/data/ttnode
ENTRYPOINT ["/data/entrypoint.sh"]