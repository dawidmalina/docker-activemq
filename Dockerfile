##
# CentOS 7 with activeMQ (inspired by aterreno / activemq-dockerfile)
##
FROM dawidmalina/docker-java8
MAINTAINER Dawid Malinowski <dawidmalina@gmail.com>

ENV REFRESHED_AT 2014-12-01
ENV JAVA_OPTS "-XX:+PrintFlagsFinal -XX:+UnlockCommercialFeatures -XX:+FlightRecorder -Xms1G -Xmx1G -verbose:gc -XX:+UseCompressedOops"

ADD start.sh /bin/start.sh
ADD http://www.apache.org/dyn/closer.cgi?path=/activemq/5.10.0/apache-activemq-5.10.0-bin.tar.gz /opt/

RUN mv apache-activemq-5.10.0/conf/activemq.xml apache-activemq-5.10.0/conf/activemq.xml.orig

RUN awk '/.*stomp.*/{print "            <transportConnector name=\"stompssl\" uri=\"stomp+nio+ssl://0.0.0.0:61612?transport.enabledCipherSuites=SSL_RSA_WITH_RC4_128_SHA,SSL_DH_anon_WITH_3DES_EDE_CBC_SHA\" />"}1' apache-activemq-5.10.0/conf/activemq.xml.orig >> apache-activemq-5.10.0/conf/activemq.xml

#VOLUME ["/var/lib/cassandra/data", "/var/lib/cassandra/commitlog"]

EXPOSE 61612 61613 61616 8161

CMD ["start.sh"]
