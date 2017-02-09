#!/bin/bash -xe

source /home/root/openrc

rally-manage db recreate
rally deployment create --fromenv --name=tempest
rally verify create-verifier --type tempest --name tempest-verifier --source /var/lib/tempest --version 14.0.0 --system-wide
rally verify configure-verifier --extend /home/root/options.conf
rally verify configure-verifier --show
