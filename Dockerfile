FROM shouldbee/scala:2.11.7-openjdk8

ENV hadoop_ver 2.7.0
ENV flink_ver 1.0.3
ENV scala_ver 2.11

# Get Hadoop from US Apache mirror and extract just the native
# libs. (Until we care about running HDFS with these containers, this
# is all we need.)
RUN mkdir -p /opt && \
    cd /opt && \
    curl http://www.us.apache.org/dist/hadoop/common/hadoop-${hadoop_ver}/hadoop-${hadoop_ver}.tar.gz | \
        tar -zx hadoop-${hadoop_ver}/lib/native && \
    ln -s hadoop-${hadoop_ver} hadoop && \
    echo Hadoop ${hadoop_ver} native libraries installed in /opt/hadoop/lib/native

# Get Flink from US Apache mirror.
RUN mkdir -p /opt && \
    cd /opt && \
    curl http://www.us.apache.org/dist/flink/flink-${flink_ver}/flink-${flink_ver}-bin-hadoop27-scala_${scala_ver}.tgz | \
        tar -zx && \
    ln -s flink-${flink_ver}-bin-hadoop27-scala_${scala_ver} flink && \
    echo Flink ${flink_ver} installed in /opt


ADD log4j.properties logback.xml /opt/flink/conf/
ADD start-common.sh start-worker.sh start-master.sh /
ADD flink-conf.yaml /opt/flink/conf/flink-conf.yaml
ENV PATH $PATH:/opt/flink/bin