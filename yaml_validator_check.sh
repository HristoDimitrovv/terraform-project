#!/bin/bash

find . -name "*.yaml" -exec yamllint -c .yamllint {} \;
exit_status=$?

if [ -z "$(find . -name '*.yaml' -exec yamllint -c .yamllint {} + 2>/dev/null)" ]; then
    echo "YAML validation succeeded."
else
    echo "YAML validation failed with exit status $exit_status."
fi

