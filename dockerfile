FROM ubuntu:focal

ENV OF_VERSION 0.11.2

RUN apt-get update && apt-get install -y software-properties-common

RUN apt-get install -y wget apt-utils

RUN wget http://openframeworks.cc/versions/v${OF_VERSION}/of_v${OF_VERSION}_linuxarmv7l_release.tar.gz
RUN tar -xzvf /of_v${OF_VERSION}_linuxarmv7l_release.tar.gz
RUN mv /of_v${OF_VERSION}_linuxarmv7l_release /openFrameworks

RUN cd /openFrameworks/scripts/linux/ubuntu/; ./install_dependencies.sh -y
#RUN cd /openFrameworks/scripts/linux/ubuntu/; ./install_codecs.sh -y

RUN cd /openFrameworks/scripts/linux/; ./compileOF.sh -j4

RUN mkdir /openFrameworks/apps/myApps/app/; ln -s /openFrameworks/apps/myApps/app/ /app

WORKDIR /openFrameworks/apps/myApps/app
ENV OF_ROOT=/openFrameworks
CMD make -j4; make run

