#!/bin/bash
tflint -f compact --recursive --only=terraform_unused_declarations
