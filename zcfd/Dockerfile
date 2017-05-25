from centos:6.9

LABEL maintainer zenotech

RUN curl -GL https://qmu9vrceva.execute-api.eu-west-1.amazonaws.com/prod/download | tar -xzC /

RUN yum -y install gcc-gfortran && yum clean all

RUN useradd -ms /bin/bash zcfd

USER zcfd
WORKDIR /home/zcfd


