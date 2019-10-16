FROM postgres:12

RUN mv /usr/local/bin/docker-entrypoint.sh /usr/local/bin/postgres-entrypoint.sh

WORKDIR /opt/kafka

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget software-properties-common supervisor\
    && wget --no-check-certificate -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
    && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
    && apt-get update \
    && apt-get install -y --no-install-recommends adoptopenjdk-12-hotspot \
    && wget http://apachemirror.wuchna.com/kafka/2.3.0/kafka_2.12-2.3.0.tgz \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove wget

RUN tar xzf kafka_2.12-2.3.0.tgz

WORKDIR /etc/mvp

COPY supervisord.conf /etc/mvp/
COPY docker-entrypoint.sh /usr/bin/

RUN mkdir /var/log/supervisord

WORKDIR /root/code

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]

CMD ["echo", "Provide command to execute"]

EXPOSE 9092
EXPOSE 2181