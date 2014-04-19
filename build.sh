#!/bin/sh

sudo docker build -t sebgod/mercury-minimal-install:${1-latest} .
