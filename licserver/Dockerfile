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

# Run the licence server
CMD ["/usr/local/RLM/rlm", "-c", "/opt/rlm/licences/server.lic"]
