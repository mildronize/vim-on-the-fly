FROM debian:testing

ENV HOME /root
ENV PASSWORD vimotf

MAINTAINER Thada Wangthammang <mildronize@gmail.com>

# Initialize config
COPY config/sources.list /etc/apt/sources.list

# Initialize ssh server
# From: https://docs.docker.com/examples/running_ssh_service/
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# ADD config/username .
# RUN chpasswd < username && rm username
RUN echo "root:$PASSWORD" | chpasswd

RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# Install git fabric

RUN apt-get -y update && apt-get install -y git \
  fabric \
  sudo \
  wget

# Install vim and other via fabric
WORKDIR ${HOME}
RUN git clone https://github.com/mildronize/dotfiles.git
WORKDIR ${HOME}/dotfiles
RUN service ssh start && fab -H localhost set_vim_on_the_fly -p $PASSWORD
WORKDIR ${HOME}/working
