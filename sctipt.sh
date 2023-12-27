        find . -name "*.yaml" -exec yamllint -c .yamllint {} \; | tee -a tmp_yamllint.log
        error_count=$(grep -c "error" tmp_yamllint.log)
        if [[ $error_count -gt 0 ]]; then
         echo "$error_count YAML linting errors found in tmp_yamllint.log"
         exit 1
        fi
