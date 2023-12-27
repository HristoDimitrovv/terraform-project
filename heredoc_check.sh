#!/bin/bash

# HereDoc Checker
#
# This solution checks if any terraform files use HereDoc declarations.
# You may want to ignore certain files from this check (for example if
# you want to have error messages in variable declarations when
# utilizing conditions and validations.
#
# Ignoring is achieved as follows:
#
# Provide list of filenames (one per line) to be ignored when checking
# for HereDoc usage in the heredoc_check.ignore file.
# Filenames should start with relative path in regards to heredoc_check.sh.
#
# Valid formats for relative path:
# terraform/variables.tf
# ./terraform/variables.tf
#
# This is needed if you happen to have two different terraform files with
# the same name but in different folders.
# You can also comment line(s) in heredoc_check.ignore to skip them
# from being ignored.
#


# Check if there are files to ignore and construct the find command appropriately

find . -type f -name "*.tf" -exec grep -H "<<" {} \; | tee -a tmp_heredoc.log

# Validate HereDoc usage based on find's results
line_count=$(wc -l < tmp_heredoc.log | awk '{print $1}')
if [[ $line_count -gt 0 ]]; then
    echo "$line_count lines in tmp_heredoc.log"
    exit 1
fi