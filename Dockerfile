FROM rallyforge/rally:0.9.1
MAINTAINER Oleksii Butenko <obutenko@mirantis.com>

WORKDIR /var/lib
USER root
RUN git clone https://git.openstack.org/openstack/tempest -b 16.0.0 && \
    pip install tempest==16.0.0
    
WORKDIR /home/rally

COPY tempest_conf /var/lib/tempest_conf
COPY run_tempest.sh /usr/bin/run-tempest
