FROM openjdk:8u252-jre

WORKDIR /opt

RUN apt update
RUN apt install net-tools
RUN apt install -y procps

ENV HADOOP_HOME=/opt/hadoop-3.2.1
ENV HIVE_HOME=/opt/apache-hive-3.1.2-bin
ENV PATH $HIVE_HOME/bin:$HADOOP_HOME/bin:$PATH

RUN curl -L https://archive.apache.org/dist/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz | tar zxf - && \
    curl -L https://archive.apache.org/dist/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz | tar zxf - && \
    rm -f ${HIVE_HOME}/lib/guava-19.0.jar && \
    cp ${HADOOP_HOME}/share/hadoop/common/lib/guava-27.0-jre.jar ${HIVE_HOME}/lib/

RUN curl -L https://jdbc.postgresql.org/download/postgresql-42.2.12.jar --output ${HIVE_HOME}/lib/postgresql-42.2.12.jar

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive -R ${HADOOP_HOME}

COPY lib/* ${HIVE_HOME}/lib/

COPY entrypoint-hive.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER hive
WORKDIR $HIVE_HOME

EXPOSE 9083
EXPOSE 10000
EXPOSE 10002

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]

COPY hive-log4j2.properties ${HIVE_HOME}/conf/hive-log4j2.properties
COPY metastore-site.xml ${HIVE_HOME}/conf/hive-site.xml