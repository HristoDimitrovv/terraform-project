#!/bin/bash

find . -name "*.yaml" -exec yamllint -c .yamllint {} \;
