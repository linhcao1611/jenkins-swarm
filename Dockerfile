FROM jenkins:latest

USER root

RUN apt-get update && apt-get install -y ca-certificates libapparmor-dev

RUN apt-get update \
    && apt-get install -y python-pip curl\
    && pip install awscli \
    && rm -rf /var/lib/apt/lists/*

ADD ./run.sh /run.sh
RUN chmod +x run.sh

ADD https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.9/swarm-client-3.9.jar /usr/share/jenkins/swarm-client.jar
RUN chmod 644 /usr/share/jenkins/swarm-client.jar
ADD ./docker/* /usr/bin/

RUN ls /usr/bin
RUN chmod +x /usr/bin/docker

ADD ./run.sh /run.sh
RUN chmod +x run.sh

USER jenkins
WORKDIR /var/jenkins_home

RUN ls -l

ENTRYPOINT ["/run.sh"]

# https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/
# https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.2/swarm-client-2.2-jar-with-dependencies.jar