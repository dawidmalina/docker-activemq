##
# CentOS 7 with activeMQ (inspired by aterreno / activemq-dockerfile)
##
FROM dawidmalina/docker-java8
MAINTAINER Dawid Malinowski <dawidmalina@gmail.com>

ENV REFRESHED_AT 2014-12-01
ENV JAVA_OPTS "-XX:+PrintFlagsFinal -XX:+UnlockCommercialFeatures -XX:+FlightRecorder -Xms1G -Xmx1G -verbose:gc -XX:+UseCompressedOops"

RUN yum -y install tar && yum clean all

ADD start.sh /bin/start.sh
ADD http://www.eu.apache.org/dist/activemq/5.10.0/apache-activemq-5.10.0-bin.tar.gz /opt/

RUN cd /opt/ \
    && tar xzf apache-activemq-5.10.0-bin.tar.gz \
    && chmod -x apache-activemq-5.10.0/bin/activemq \
    && mv apache-activemq-5.10.0/conf/activemq.xml apache-activemq-5.10.0/conf/activemq.xml.orig \
    && awk '/.*stomp.*/{print "            <transportConnector name=\"stompssl\" uri=\"stomp+nio+ssl://0.0.0.0:61612?transport.enabledCipherSuites=SSL_RSA_WITH_RC4_128_SHA,SSL_DH_anon_WITH_3DES_EDE_CBC_SHA\" />"}1' apache-activemq-5.10.0/conf/activemq.xml.orig >> apache-activemq-5.10.0/conf/activemq.xml

VOLUME ["/opt/apache-activemq-5.10.0/data/"]

EXPOSE 61612 61613 61616 8161

CMD ["start.sh"]
