FROM ubuntu:latest

ENV DEBIAN_FRONTEND="nointeractive"

RUN apt-get -qq update && \
  apt-get -qq install -y git python3 python3-pip curl ffmpeg locales tzdata cmake gcc g++ gcc-8 g++-8 python3-dev openssl libssl-dev libopus0 libopus-dev
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8
RUN apt update && apt install -y neofetch
RUN apt-get install -y build-essential && \
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
