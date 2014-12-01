#!/bin/bash

JAVA_CMD="/usr/bin/java"

CMD="-Djava.util.logging.config.file=logging.properties -jar /opt/apache-activemq-5.10.0/bin/activemq.jar start"

# RUN
eval ${JAVA_CMD} ${JAVA_OPT} ${CMD} 2>&1
