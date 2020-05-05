#!/bin/bash

set -x

#Time the exact service calls that interlock would make
mkdir /tmp/apitimings

time (curl --unix-socket /var/run/docker.sock http:///v1.4.0/services) &> /tmp/apitimings/services.txt
time (curl --unix-socket /var/run/docker.sock http:///v1.4.0/tasks?filters=%7B%22desired-state%22%3A%7B%22running%22%3Atrue%7D%7D) &> /tmp/apitimings/tasks.txt

