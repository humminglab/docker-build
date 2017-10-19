# Base docker image for building embedded development envirionments

FROM ubuntu:latest
MAINTAINER YongSung Lee <yslee@humminglab.io>

# change it to korea mirror
RUN sed -i -e 's/archive.ubuntu/kr.archive.ubuntu/' /etc/apt/sources.list

# make sure the package repository is up to date
RUN apt-get update && apt-get -y upgrade

# install required packages
RUN apt-get install -y git openssh-server

# enable root login
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22

CMD ["bin/bash"]
