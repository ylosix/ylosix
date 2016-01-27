#!/bin/bash

# Commands required to ensure correct docker containers are started when the vm is rebooted.

docker start postgres
docker start rails

mailcatcher --ip 0.0.0.0