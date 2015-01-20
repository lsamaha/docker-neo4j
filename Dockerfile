FROM debian:wheezy
MAINTAINER lwsamaha

# users

RUN useradd -s /bin/nologin neo

# tools

RUN apt-get update && apt-get install -y \
    wget \
    openjdk-7-jre-headless
RUN apt-get clean autoclean && \
    apt-get autoremove

# dirs

ENV appdir /opt
ENV neodir /opt/neo4j
ENV datadir /opt/neo4j/data
ENV tmpdir ~/tmp
WORKDIR ${tmpdir}

# neo4j

RUN echo ${appdir}
RUN echo ${neodir}
RUN echo ${datadir}
RUN wget -t 3 -q -O - http://neo4j.com/artifact.php?name=neo4j-community-2.2.0-M02-unix.tar.gz | tar zxf - -C ${appdir} 
RUN ln -s ${appdir}/neo4j-community-2.2.0-M02/ ${neodir} 
RUN mkdir -p ${datadir}
RUN chown -R neo:neo ${neodir}
RUN chown -R neo:neo ${datadir}

# network config

EXPOSE 7473 7474
RUN sed -i 's/#org.neo4j.server.webserver.address/org.neo4j.server.webserver.address/g' ${neodir}/conf/neo4j-server.properties

# startup

RUN ${neodir}/bin/neo4j start-no-wait && tail -f ${neodir}/data/log/*.log &

