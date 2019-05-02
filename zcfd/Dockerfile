from centos:7

LABEL maintainer zenotech

RUN curl -GL https://qmu9vrceva.execute-api.eu-west-1.amazonaws.com/prod/download | tar -xzC /

RUN useradd -ms /bin/bash zcfd

USER zcfd
WORKDIR /home/zcfd
