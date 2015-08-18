FROM stangenberg/docker-docker:latest

MAINTAINER Thorben Stangenberg <thorben@stangenberg.ch>

# Add repo and update apt
RUN \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update
  
# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get install -y oracle-java8-installer
  
# Install build tools
RUN \
  apt-get install -y build-essential
 
# Install Cloud9 ssh requirements
RUN \
  curl -L https://raw.githubusercontent.com/c9/install/master/install.sh | bash

# Install docker compose
RUN \
  curl -L https://github.com/docker/compose/releases/download/1.4.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

# install typesafe activator
RUN \
  apt-get install unzip && \
  wget http://downloads.typesafe.com/typesafe-activator/1.3.5/typesafe-activator-1.3.5.zip && \
  unzip typesafe-activator-1.3.5.zip && \
  mv activator-dist-1.3.5 /opt && \
  ln /opt/activator-dist-1.3.5/activator /usr/local/bin/activator && \
  ln /opt/activator-dist-1.3.5/activator-launch-1.3.5.jar /usr/local/bin/activator-launch-1.3.5.jar

# install nvm
RUN \

  apt-get install -y libssl-dev && \
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.0/install.sh | bash

# Create workspace directory
RUN mkdir ~/ws

# expose workspace as volume 
VOLUME /root/ws

# add ssh key
RUN sed -i '$ a\ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeI07XG0lI2+/9vtY3qjwT2Nc41oyrfwdjrVtvXQ/OYXVdJL8NxAN3U71AO9p1kus0pWclqwmEjyqas7NXRFO3m3v1m0OarkoAnF8cW1dcALvbcYtK4bT55qi449d7YF5dSfyXcYXu9tFUvhmqFy664Esu8mh8OzH2Zrfq261v9RjVHNHqFdcf82p89/Vr8IHotnmI1Hg8VuWtN6bT8pJP493EF36AH2AfWafVvJTXEOTfUZEpG52qcT9seCRNa0odThOTNT31jKAZeVtzrc6KGuj5zawyRz9sZkUQxs2jbEJE9mnz8yWlGjIU/6oKvHcW61HWAX3e+zDOL6QILrU5 thorben@stangenberg.ch' ~/.ssh/authorized_keys

# Clean up when done.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
           /tmp/* \
           /var/cache/* \
           /var/tmp/* 
