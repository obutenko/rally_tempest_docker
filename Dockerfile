FROM rallyforge/rally:0.8.1
MAINTAINER <obutenko@mirantis.com>

WORKDIR /var/lib
USER root
RUN git clone https://git.openstack.org/openstack/tempest -b 14.0.0 && \
    pip install tempest==14.0.0
    
WORKDIR /home/rally
# Switch to the 'rally' user back.
USER rally
# NOTE: Before building a docker image you can create own setup_tempest.sh
#       script for setting up Tempest and use it instead of the default script.
#       In order to make the default script work correctly, you have to create
#       an keystonercv3 file in the docker container before executing the setup-tempest
#       command. An example of the keystonercv3 file:
#
#       export OS_TENANT_NAME='admin'
#       export OS_PROJECT_NAME='admin'
#       export OS_USERNAME='admin'
#       export OS_PASSWORD='admin'
#       export OS_AUTH_URL='http://10.109.1.9:5000/v3/'
#       export OS_AUTH_STRATEGY='keystone'
#       export OS_REGION_NAME='RegionOne'
#       export CINDER_ENDPOINT_TYPE='internalURL'
#       export GLANCE_ENDPOINT_TYPE='internalURL'
#       export KEYSTONE_ENDPOINT_TYPE='internalURL'
#       export NOVA_ENDPOINT_TYPE='internalURL'
#       export NEUTRON_ENDPOINT_TYPE='internalURL'
#       export OS_ENDPOINT_TYPE='internalURL'
#       export OS_CACERT='/var/lib/astute/haproxy/public_haproxy.pem'
#       export OS_PROJECT_DOMAIN_NAME='Default'
#       export OS_USER_DOMAIN_NAME='Default'
#       export OS_IDENTITY_API_VERSION='3'
COPY setup_tempest.sh /usr/bin/setup-tempest
COPY options.conf /var/lib/extra_options.conf
