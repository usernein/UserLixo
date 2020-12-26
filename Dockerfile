FROM ubuntu:latest

ENV DEBIAN_FRONTEND="nointeractive"

RUN apt-get update \
 && apt-get install -y sudo

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

RUN sudo apt-get -qq update && \
  sudo apt-get -qq install -y git python3 python3-pip curl ffmpeg locales tzdata
RUN sudo apt update && sudo apt install -y neofetch
RUN sudo apt-get install -y build-essential && \
  git clone https://github.com/dtcooper/fakehostname.git && \
  cd fakehostname && \
  make && make install

RUN git clone https://github.com/AmanoTeam/UserLixo /usr/src/app/Userlixo
COPY . /usr/src/app/Userlixo
WORKDIR /usr/src/app/Userlixo

RUN pip3 install -U pip setuptools wheel
RUN pip3 install -Ur requirements-heroku.txt

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD fakehostname $FAKE_HOSTNAME python3 -m userlixo
