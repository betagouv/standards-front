#!/bin/sh

yq 'explode(.)' -o yaml < test.yaml.template > test.yaml
