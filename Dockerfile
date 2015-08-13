FROM phusion/baseimage:0.9.17

MAINTAINER Andrew Teixeira <teixeira@broadinstitute.org>

EXPOSE 2480
EXPOSE 2424

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/usr/lib/jvm/java-7-oracle \
    ORIENTDB_VERSION=2.1.0

RUN apt-get update && \
    apt-get -yq install \
    python-software-properties \
    software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get -yq install oracle-java7-installer && \
    update-alternatives --display java && \
    mkdir -p /etc/service/orientdb/supervise && \
    wget http://orientdb.com/download.php?email=unknown@unknown.com\&file=orientdb-community-$ORIENTDB_VERSION.tar.gz\&os=linux -O /tmp/orientdb-community-$ORIENTDB_VERSION.tar.gz && \
    cd /opt && tar -zxf /tmp/orientdb-community-$ORIENTDB_VERSION.tar.gz && \
    cd /opt && mv orientdb-community-$ORIENTDB_VERSION orientdb && \
    apt-get -yq clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

ADD run.sh /etc/service/orientdb/run

RUN chmod 755 /etc/service/orientdb/run

# Notes: https://github.com/orientechnologies/orientdb-docker

# Setting up java 7
# RUN apt-get install -y python-software-properties
# RUN apt-get install -y software-properties-common
# RUN add-apt-repository ppa:webupd8team/java -y

# RUN apt-get update
# RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# and install java 7 oracle jdk
# RUN apt-get -y install oracle-java7-installer && apt-get clean
# RUN update-alternatives --display java
# ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
# RUN mkdir -p /opt/bbytes
# ADD orientdb-1.7.zip /opt/bbytes/orientdb-1.7.zip
# RUN apt-get install unzip
# RUN  cd /opt/bbytes ; unzip orientdb-1.7.zip
# RUN cd /opt/bbytes/orientdb-1.7/bin; chmod 744 -R .

#CMD cd /opt/bbytes/orientdb-1.7/bin; ./server.sh
