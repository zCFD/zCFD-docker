FROM ubuntu:latest

RUN apt-get -qq update
RUN apt-get install wget -y

# Get vendor deamon


# Update Reprise to latest version
RUN wget http://www.reprisesoftware.com/license_admin_kits/x64_l1.admin.tar.gz
RUN tar xzf x64_l1.admin.tar.gz
RUN rm x64_l1.admin.tar.gz
RUN mkdir /usr/local/RLM && cp /x64_l1.admin/rlm /usr/local/RLM/rlm

VOLUME /opt/rlm/licences

# rlm server
EXPOSE 5053
# admin gui
EXPOSE 5054
# isv server
EXPOSE 5056 

# Default to run as primary license server
ENV PRIMARY_SERVER 1

ADD run_server /usr/local/RLM/

# Run the licence server
CMD ["/usr/local/RLM/run_server", "/opt/rlm/licences"]
