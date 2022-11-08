FROM debian:buster-slim
LABEL maintainer="waterlemons2k <waterlemons2k@gmail.com>"
ENV DISABLE=0

COPY ["cron", "entrypoint.sh", "localtime", "signin", "token", "ttnode", "yfapp.conf", "/data/"]
RUN cd /data &&\
    chmod +x entrypoint.sh signin token ttnode &&\
    mv localtime /etc &&\
    mv cron /etc/cron.d/cron &&\
    apt-get update && apt-get install --no-install-recommends -y cron procps && apt-get clean &&\
    rm -rf /var/cache/* /var/lib/apt/lists/* &&\
    crontab /etc/cron.d/cron

VOLUME /mnt/data/ttnode
ENTRYPOINT ["/data/entrypoint.sh"]