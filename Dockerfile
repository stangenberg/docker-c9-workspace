FROM phusion/baseimage

MAINTAINER Thorben Stangenberg <thorben@stangenberg.ch>

ENV DOCKER_COMPOSE_VERSION=1.6.2 \
    ACTIVATOR_VERSION=1.3.7 \
    NVM_VERSION=v0.31.0

# Add repo and update apt
RUN \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update

# Install build tools
RUN \
  apt-get install -y \
  build-essential \
  python

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get install -y oracle-java8-installer
ENV \
  JAVA_HOME=/usr/lib/jvm/java-8-oracle

# Install Cloud9 ssh requirements
RUN \
  curl -L https://raw.githubusercontent.com/c9/install/master/install.sh | bash

# Install docker compose
RUN \
  curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

# install typesafe activator
RUN \
  apt-get install unzip && \
  wget -P /tmp https://downloads.typesafe.com/typesafe-activator/$ACTIVATOR_VERSION/typesafe-activator-$ACTIVATOR_VERSION-minimal.zip && \
  unzip /tmp/typesafe-activator-$ACTIVATOR_VERSION-minimal.zip -d /opt

RUN \
  ls -la /opt && \
  ln /opt/activator-$ACTIVATOR_VERSION-minimal/activator /usr/local/bin/activator && \
  ln /opt/activator-$ACTIVATOR_VERSION-minimal/activator-launch-$ACTIVATOR_VERSION.jar /usr/local/bin/activator-launch-$ACTIVATOR_VERSION.jar
ENV \
  ACTIVATOR_HOME=/opt/activator-$ACTIVATOR_VERSION-minimal

# install nvm node
RUN \
  apt-get install -y libssl-dev && \
  curl -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash && \
  . /root/.nvm/nvm.sh && \
  nvm install stable

# Create workspace directory
RUN mkdir /workspace

# expose workspace as volume
VOLUME /workspace

# enable ssh deamon
RUN rm -f /etc/service/sshd/down && \
# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
  /etc/my_init.d/00_regen_ssh_host_keys.sh

# add ssh key
RUN touch ~/.ssh/authorized_keys && \
    sed -i '$ a\ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeI07XG0lI2+/9vtY3qjwT2Nc41oyrfwdjrVtvXQ/OYXVdJL8NxAN3U71AO9p1kus0pWclqwmEjyqas7NXRFO3m3v1m0OarkoAnF8cW1dcALvbcYtK4bT55qi449d7YF5dSfyXcYXu9tFUvhmqFy664Esu8mh8OzH2Zrfq261v9RjVHNHqFdcf82p89/Vr8IHotnmI1Hg8VuWtN6bT8pJP493EF36AH2AfWafVvJTXEOTfUZEpG52qcT9seCRNa0odThOTNT31jKAZeVtzrc6KGuj5zawyRz9sZkUQxs2jbEJE9mnz8yWlGjIU/6oKvHcW61HWAX3e+zDOL6QILrU5 thorben@stangenberg.ch' ~/.ssh/authorized_keys

# install tools & oh-my-zsh
RUN \
  apt-get install -y \
    git \
    tree \
    zsh && \
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
