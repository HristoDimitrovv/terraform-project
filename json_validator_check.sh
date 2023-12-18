#!/bin/bash

find . -name "*.json" -exec python3 json_validator.py {} +

