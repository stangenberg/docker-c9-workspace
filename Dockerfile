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
ENV \
  JAVA_HOME=/usr/lib/jvm/java-8-oracle

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
  wget -P /tmp http://downloads.typesafe.com/typesafe-activator/1.3.5/typesafe-activator-1.3.5.zip && \
  unzip /tmp/typesafe-activator-1.3.5.zip -d /opt

RUN \
  ls -la /opt && \
  ln /opt/activator-dist-1.3.5/activator /usr/local/bin/activator && \
  ln /opt/activator-dist-1.3.5/activator-launch-1.3.5.jar /usr/local/bin/activator-launch-1.3.5.jar
ENV \
  ACTIVATOR_HOME=/opt/activator-dist-1.3.5

# install nvm node
RUN \
  apt-get install -y libssl-dev && \
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.0/install.sh | bash && \
  . /root/.nvm/nvm.sh && \
  nvm install v0.12.7

# Create workspace directory
RUN mkdir ~/ws

# expose workspace as volume
VOLUME /root/ws

# add ssh key
RUN sed -i '$ a\ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeI07XG0lI2+/9vtY3qjwT2Nc41oyrfwdjrVtvXQ/OYXVdJL8NxAN3U71AO9p1kus0pWclqwmEjyqas7NXRFO3m3v1m0OarkoAnF8cW1dcALvbcYtK4bT55qi449d7YF5dSfyXcYXu9tFUvhmqFy664Esu8mh8OzH2Zrfq261v9RjVHNHqFdcf82p89/Vr8IHotnmI1Hg8VuWtN6bT8pJP493EF36AH2AfWafVvJTXEOTfUZEpG52qcT9seCRNa0odThOTNT31jKAZeVtzrc6KGuj5zawyRz9sZkUQxs2jbEJE9mnz8yWlGjIU/6oKvHcW61HWAX3e+zDOL6QILrU5 thorben@stangenberg.ch' ~/.ssh/authorized_keys

# install oh-my-zsh
RUN \
  apt-get install -y zsh && \
  git clone https://github.com/tstangenberg/oh-my-zsh.git ~/.oh-my-zsh && \
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \
  chsh -s /bin/zsh
ADD zshrc ~/.zshrc
ADD tmux.conf ~/.tmux.conf

# Clean up when done.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
           /tmp/* \
           /var/cache/* \
           /var/tmp/*
