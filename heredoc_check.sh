#!/bin/bash

# Check for the occurence of << (here document) in the .tf files 

find . -name "*.tf" -exec grep -H "<<" {} \; > tmp_heredoc_validation.log
cat tmp_heredoc_validation.log
[[ $(wc -l tmp_heredoc_validation.log | awk '{print $1}') -gt 0 ]] && exit 1 || exit 0
