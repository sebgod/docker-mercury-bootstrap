#!/bin/sh

sudo docker build -t sebgod/mercury-bootstrap:${1-latest} .
