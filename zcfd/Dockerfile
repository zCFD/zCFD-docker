from centos:7 as download

RUN curl -GL -o zCFD.tgz https://qmu9vrceva.execute-api.eu-west-1.amazonaws.com/prod/download
#COPY zCFD.tgz .
RUN cd / && tar -xzf zCFD.tgz;  mv /zCFD-* /zcfd

from centos:7

LABEL maintainer zenotech

RUN yum -y install libpciaccess numactl which && yum clean all

RUN useradd -ms /bin/bash zcfd && mkdir /data && chown zcfd /data

COPY --chown=zcfd --from=download /zcfd /zcfd

USER zcfd
WORKDIR /data

ENV RLM_LICENSE 6054@licsvr.zenotech.com
ENV RLM_LICENSE_PASSWORD "setme"
CMD /zcfd/bin/run_zcfd
