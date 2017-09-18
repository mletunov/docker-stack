# Based on https://bitbucket.org/grahamrb/atlassian-docker
FROM ubuntu:16.04
MAINTAINER Maxim Letunov <letunov.ms@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
	&& apt-get install -y git-core curl wget zip sudo xmlstarlet \
	software-properties-common python-software-properties \
	&& rm -rf /var/lib/apt/lists/*

# Install Java 7
RUN apt-add-repository ppa:webupd8team/java -y \
	&& apt-get update && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
	&& mkdir /var/cache/oracle-jdk7-installer \
	&& wget -P /var/cache/oracle-jdk7-installer/ http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-7u80-linux-x64.tar.gz \
	&& apt-get install oracle-java7-installer -y \
	&& rm -rf /var/lib/apt/lists/*

# Setup volume handling
ADD own-volume.sh /usr/local/bin/own-volume
RUN /usr/sbin/groupadd atlassian && mkdir -p /opt/atlassian-home \
	&& echo "%atlassian ALL=NOPASSWD: /usr/local/bin/own-volume" >> /etc/sudoers

# Add common script functions
ADD common.bash /usr/local/share/atlassian/common.bash
RUN chgrp atlassian /usr/local/share/atlassian/common.bash \
	&& chmod g+w /usr/local/share/atlassian/common.bash

# Install Jira
ENV JIRA_VERSION 6.2.1
RUN curl -Lks http://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-${JIRA_VERSION}.tar.gz -o /root/jira.tar.gz \
	&& /usr/sbin/useradd --create-home --home-dir /opt/jira --groups atlassian --shell /bin/bash jira \
	&& tar zxf /root/jira.tar.gz --strip=1 -C /opt/jira \
	&& chown -R jira:jira /opt/atlassian-home \
	&& echo "jira.home = /opt/atlassian-home" > /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties \
	&& chown -R jira:jira /opt/jira \
	&& mv /opt/jira/conf/server.xml /opt/jira/conf/server-backup.xml

# Patch Jira
ADD *.jar /tmp/
RUN mv /tmp/atlassian-extras-2.2.2.jar /opt/jira/atlassian-jira/WEB-INF/lib/atlassian-extras-2.2.2.jar \
	&& zip -d /opt/jira/atlassian-jira/WEB-INF/classes/atlassian-bundled-plugins.zip atlassian-universal-plugin-manager-plugin-2.15.jar \
	&& zip -mj /opt/jira/atlassian-jira/WEB-INF/classes/atlassian-bundled-plugins.zip /tmp/atlassian-universal-plugin-manager-plugin-2.10.1.jar	

ENV CONTEXT_PATH ROOT
ADD launch.bash /launch

# Launching Jira
WORKDIR /opt/jira
VOLUME ["/opt/atlassian-home"]
EXPOSE 8080
USER jira
CMD ["/launch"]