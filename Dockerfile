FROM rallyforge/rally:0.8.1
MAINTAINER <obutenko@mirantis.com>

WORKDIR /var/lib
# We need to switch to the 'root' user to avoid permission issues.
USER root
RUN git clone https://git.openstack.org/openstack/tempest -b 14.0.0 && \
    pip install tempest==14.0.0

WORKDIR /home/rally
# Switch to the 'rally' user back.
USER rally

# NOTE: Before building a docker image you can create own setup_tempest.sh
#       script for setting up Tempest and use it instead of the default script.
#       In order to make the default script work correctly, you have to create
#       an openrc file in the docker container before executing the setup-tempest
#       command. An example of the openrc file:
#
#       #!/bin/sh
#       export OS_TENANT_NAME='admin'
#       export OS_USERNAME='admin'
#       export OS_PASSWORD='admin'
#       export OS_AUTH_URL='http://10.109.1.9:5000/v2.0'
#       export OS_REGION_NAME='RegionOne'
#       export OS_ENDPOINT_TYPE='internalURL'
COPY setup_tempest.sh /usr/bin/setup-tempest
COPY options.conf /home/rally/options.conf
