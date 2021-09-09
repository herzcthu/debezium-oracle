FROM quay.io/strimzi/kafka:0.25.0-kafka-2.8.0

ENV KAFKA_HOME=/opt/kafka

USER root:root

RUN cd /tmp; \
    curl -LO https://download.oracle.com/otn_software/linux/instantclient/213000/instantclient-basic-linux.x64-21.3.0.0.0.zip; \
    unzip instantclient-basic-linux.x64-21.3.0.0.0.zip; \
    cp instantclient_21_3/* ${KAFKA_HOME}/libs; \
    rm -rf instantclient_21_3; \
    rm instantclient-basic-linux.x64-21.3.0.0.0.zip

##########
# Connector plugin debezium-oracle-connect
##########
RUN mkdir -p ${KAFKA_HOME}/plugins/debezium-oracle-connect/deaf1cc4 \
        && curl -L --output ${KAFKA_HOME}/plugins/debezium-oracle-connect/deaf1cc4.tgz https://repo1.maven.org/maven2/io/debezium/debezium-connector-oracle/1.6.1.Final/debezium-connector-oracle-1.6.1.Final-plugin.tar.gz \
        && echo "fe5eb4d0dda150b10d24a6d9f3a631c493267a0dee2d72167a8841af5804c43a908d149e5bc4a87dc48f0747e26a1d85a930225eea7b9709726ea2abda95b487 ${KAFKA_HOME}/plugins/debezium-oracle-connect/deaf1cc4.tgz" > ${KAFKA_HOME}/plugins/debezium-oracle-connect/deaf1cc4.tgz.sha512 \
        && sha512sum --check ${KAFKA_HOME}/plugins/debezium-oracle-connect/deaf1cc4.tgz.sha512 \
        && rm -f ${KAFKA_HOME}/plugins/debezium-oracle-connect/deaf1cc4.tgz.sha512 \
        && tar xvfz ${KAFKA_HOME}/plugins/debezium-oracle-connect/deaf1cc4.tgz -C ${KAFKA_HOME}/plugins/debezium-oracle-connect/deaf1cc4 \
        && rm -vf ${KAFKA_HOME}/plugins/debezium-oracle-connect/deaf1cc4.tgz

USER 1001
