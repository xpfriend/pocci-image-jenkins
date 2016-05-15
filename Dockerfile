FROM jenkins:1.651.2
MAINTAINER ototadana@gmail.com

USER root

RUN apt-get update \
    && apt-get install -y sudo vim \
    && rm -rf /var/lib/apt/lists/*

RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers

COPY ./config/. /config/
RUN mkdir /config/plugins
RUN chown -R jenkins:jenkins /config
RUN chmod +x /config/*

USER jenkins
RUN /usr/local/bin/plugins.sh /config/plugins.txt

ENTRYPOINT ["/config/entrypoint"]
CMD ["/usr/local/bin/jenkins.sh"]
