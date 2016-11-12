FROM denvazh/scala:2.11.8-openjdk8

ARG HADOOP_VERSION=27
ARG FLINK_VERSION=1.1.3
ARG SCALA_BINARY_VERSION=2.11

ENV FLINK_INSTALL_PATH /opt
ENV FLINK_HOME $FLINK_INSTALL_PATH/flink
ENV PATH $PATH:$FLINK_HOME/bin

RUN set -x && \
    mkdir -p ${FLINK_INSTALL_PATH} && \
    apk --update add --virtual curl && \
    curl -s https://people.apache.org/~mxm/flink-1.1.3-custom-akka3.zip -o $FLINK_INSTALL_PATH/flink-dist.zip && \
    unzip $FLINK_INSTALL_PATH/flink-dist.zip -d ${FLINK_INSTALL_PATH} && \
    ln -s ${FLINK_INSTALL_PATH}/flink-${FLINK_VERSION}-custom-akka3 ${FLINK_HOME} && \
    sed -i -e "s/echo \$mypid >> \$pid/echo \$mypid >> \$pid \&\& wait/g" ${FLINK_HOME}/bin/flink-daemon.sh && \
    sed -i -e "s/ > \"\$out\" 2>&1 < \/dev\/null//g" ${FLINK_HOME}/bin/flink-daemon.sh && \
    rm -rf /var/cache/apk/* && \
    echo Installed Flink ${FLINK_VERSION}-custom-akka3 to ${FLINK_HOME}

ADD docker-entrypoint.sh ${FLINK_HOME}/bin/
# Additional output to console, allows gettings logs with 'docker-compose logs'
ADD log4j.properties ${FLINK_HOME}/conf/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh", "-c"]
