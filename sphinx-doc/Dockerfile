#
# ddidier/sphinx-doc
#
# A Docker image for the Sphinx documentation builder (http://sphinx-doc.org).
#
# docker build -t zenotech/sphinx-doc .

FROM       debian:sid-slim
MAINTAINER Zenotech

# OpenJDK installation issue
# - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
# - mkdir -p /usr/share/man/man1

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        python3 python3-pip python3-setuptools

RUN mkdir -p /usr/share/man/man1 \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        gosu sudo \
        curl make \
        dvipng graphviz \
        openjdk-11-jre-headless \
        latexmk texlive-fonts-recommended texlive-full texlive-latex-extra texlive-latex-recommended \
        texlive-lang-french \
        git \
    \
 && PLANTUML_VERSION=1.2019.5 \
 && mkdir /opt/plantuml \
 && curl https://netix.dl.sourceforge.net/project/plantuml/${PLANTUML_VERSION}/plantuml.${PLANTUML_VERSION}.jar --output /opt/plantuml/plantuml.${PLANTUML_VERSION}.jar \
 && ln -s /opt/plantuml/plantuml.${PLANTUML_VERSION}.jar /opt/plantuml/plantuml.jar \
    \
 && pip3 install 'Sphinx                        == 1.8.5'    \
                'alabaster                     == 0.7.12'   \
                'gitpython                     == 2.1.11'   \
                'guzzle_sphinx_theme           == 0.7.11'   \
                'livereload                    == 2.5.2'    \
                'recommonmark                  == 0.4.0'    \
                'rinohtype                     == 0.2.1'    \
                'sphinx-autobuild              == 0.7.1'    \
                'sphinx_bootstrap_theme        == 0.7.1'    \
                'sphinx-prompt                 == 1.1.0'    \
                'sphinx_rtd_theme              == 0.4.3'    \
                'sphinxcontrib-actdiag         == 0.8.5'    \
                'sphinxcontrib-blockdiag       == 1.5.5'    \
                'sphinxcontrib-excel-table     == 1.0.4'    \
                'sphinxcontrib-fulltoc         == 1.2.0'    \
                'sphinxcontrib-googleanalytics == 0.1'      \
                'sphinxcontrib-googlechart     == 0.2.1'    \
                'sphinxcontrib-googlemaps      == 0.1.0'    \
                'sphinxcontrib-nwdiag          == 0.9.5'    \
                'sphinxcontrib-plantuml        == 0.15'     \
                'sphinxcontrib-seqdiag         == 0.8.5'    \
    \
 && apt-get autoremove -y \
 && rm -rf /var/cache/* \
 && rm -rf /var/lib/apt/lists/*

COPY files/opt/ddidier/sphinx/bash/*    /opt/ddidier/sphinx/bash/
COPY files/opt/ddidier/sphinx/init/*    /opt/ddidier/sphinx/init/
COPY files/opt/ddidier/sphinx/python/*  /opt/ddidier/sphinx/python/
COPY files/usr/local/bin/*              /usr/local/bin/
COPY files/usr/share/ddidier/*          /usr/share/ddidier/

RUN chown root:root /usr/local/bin/* \
 && chmod 755 /usr/local/bin/*

ENV DATA_DIR=/doc

WORKDIR $DATA_DIR

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

